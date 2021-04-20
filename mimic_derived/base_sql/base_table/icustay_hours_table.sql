DROP TABLE IF EXISTS {mimic_derived}.icustay_hours;

CREATE TABLE {mimic_derived}.icustay_hours (
  icustay_id integer,
  hr integer,
  endtime timestamp without time zone
);
