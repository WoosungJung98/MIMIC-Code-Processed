-- create a table which has fuzzy boundaries on hospital admission
-- involves first creating a lag/lead version of disch/admit time
with h as
(
  select
    subject_id, hadm_id, admittime, dischtime
    , lag (dischtime) over (partition by subject_id order by admittime) as dischtime_lag
    , lead (admittime) over (partition by subject_id order by admittime) as admittime_lead
  from {mimic_clinical}.admissions
)
, adm as
(
  select
    h.subject_id, h.hadm_id
    -- this rule is:
    --  if there are two hospitalizations within 24 hours, set the start/stop
    --  time as half way between the two admissions
    , case
        when h.dischtime_lag is not null
        and h.dischtime_lag > (h.admittime - INTERVAL '24 hours')
          then (h.admittime - make_interval(secs => cast(extract(epoch from h.admittime - h.dischtime_lag)/2 as bigint)))
      else (h.admittime - INTERVAL '12 hours')
      end as data_start
    , case
        when h.admittime_lead is not null
        and h.admittime_lead < (h.dischtime + INTERVAL '24 hours')
          then (h.dischtime + make_interval(secs => cast(extract(epoch from h.admittime_lead - h.dischtime)/2 as bigint)))
      else (h.dischtime + INTERVAL '12 hours')
      end as data_end
    from h
)
-- get first/last heart rate measurement during hospitalization for each ICUSTAY_ID
, t1 as
(
select ce.icustay_id
, min(charttime) as intime_hr
, max(charttime) as outtime_hr
from {mimic_clinical}.chartevents ce
-- very loose join to admissions to ensure charttime is near patient admission
inner join adm
  on ce.hadm_id = adm.hadm_id
  and ce.charttime >= adm.data_start
  and ce.charttime <  adm.data_end
-- only look at heart rate
where ce.itemid in (211,220045)
group by ce.icustay_id
)
-- add in subject_id/hadm_id
insert into {mimic_derived}.icustay_times
select
  ie.subject_id, ie.hadm_id, ie.icustay_id
  , t1.intime_hr
  , t1.outtime_hr
from {mimic_clinical}.icustays ie
left join t1
  on ie.icustay_id = t1.icustay_id
order by ie.subject_id, ie.hadm_id, ie.icustay_id;
