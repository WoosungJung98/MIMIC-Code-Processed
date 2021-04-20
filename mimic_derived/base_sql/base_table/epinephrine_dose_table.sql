DROP TABLE IF EXISTS {mimic_derived}.epinephrine_dose;

CREATE TABLE {mimic_derived}.epinephrine_dose (
  icustay_id integer,
  starttime timestamp without time zone,
  endtime timestamp without time zone,
  vaso_rate double precision,
  vaso_amount double precision
);
