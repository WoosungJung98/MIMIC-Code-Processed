DROP TABLE IF EXISTS {mimic_derived}.ventilation_classification;

CREATE TABLE {mimic_derived}.ventilation_classification (
  icustay_id integer,
  charttime timestamp without time zone,
  mechvent integer,
  oxygentherapy integer,
  extubated integer,
  selfextubated integer
);
