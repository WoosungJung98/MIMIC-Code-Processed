DROP TABLE IF EXISTS {mimic_derived}.icustay_times;

CREATE TABLE {mimic_derived}.icustay_times (
  subject_id integer,
  hadm_id integer,
  icustay_id integer,
  intime_hr timestamp without time zone,
  outtime_hr timestamp without time zone
);
