-- This query generates a row for every hour the patient is in the ICU.
-- The hours are based on clock-hours (i.e. 02:00, 03:00).
-- The hour clock starts 24 hours before the first heart rate measurement.
-- Note that the time of the first heart rate measurement is ceilinged to the hour.

-- this query extracts the cohort and every possible hour they were in the ICU
-- this table can be to other tables on ICUSTAY_ID and (ENDTIME - 1 hour,ENDTIME]

-- get first/last measurement time
with all_hours as
(
select
  it.icustay_id
  -- ceiling the intime to the nearest hour by adding 59 minutes then truncating
  -- note thart we truncate by parsing as string, rather than using DATETIME_TRUNC
  -- this is done to enable compatibility with psql
  , to_timestamp(to_char((it.intime_hr + INTERVAL '59 minutes'), 'yyyy-mm-dd HH24:00:00'), 'yyyy-mm-dd HH24:00:00') as endtime
  -- create integers for each charttime in hours from admission
  -- so 0 is admission time, 1 is one hour after admission, etc, up to ICU disch
  --  we allow 24 hours before ICU admission (to grab labs before admit)
  , generate_series(-24, cast(ceil(extract(epoch from it.outtime_hr - it.intime_hr)/3600.0) as int)) as hrs
  from {mimic_derived}.icustay_times it
)
insert into {mimic_derived}.icustay_hours
select icustay_id
, hrs as hr
, (endtime + make_interval(hours => hrs)) as endtime
from all_hours;
