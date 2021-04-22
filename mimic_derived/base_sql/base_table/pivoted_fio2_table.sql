DROP TABLE IF EXISTS {mimic_derived}.pivoted_fio2;

CREATE TABLE {mimic_derived}.pivoted_fio2 (
  icustay_id integer,
  charttime timestamp without time zone,
  fio2 double precision
);
