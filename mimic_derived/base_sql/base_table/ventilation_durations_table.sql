DROP TABLE IF EXISTS {mimic_derived}.ventilation_durations;

CREATE TABLE {mimic_derived}.ventilation_durations (
  icustay_id int,
  ventnum int,
  starttime timestamp without time zone,
  endtime timestamp without time zone,
  duration_hours int
);
