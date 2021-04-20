DROP TABLE IF EXISTS {mimic_derived}.weight_durations;

CREATE TABLE {mimic_derived}.weight_durations (
  icustay_id integer,
  starttime timestamp without time zone,
  endtime timestamp without time zone,
  weight double precision
);
