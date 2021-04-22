DROP TABLE IF EXISTS {mimic_derived}.pivoted_lab;

CREATE TABLE {mimic_derived}.pivoted_lab (
  icustay_id integer,
  hadm_id integer,
  subject_id integer,
  charttime timestamp without time zone,
  aniongap double precision,
  albumin double precision,
  bands double precision,
  bicarbonate double precision,
  bilirubin double precision,
  creatinine double precision,
  chloride double precision,
  glucose double precision,
  hematocrit double precision,
  hemoglobin double precision,
  lactate double precision,
  platelet double precision,
  potassium double precision,
  ptt double precision,
  inr double precision,
  pt double precision,
  sodium double precision,
  bun double precision,
  wbc double precision
);
