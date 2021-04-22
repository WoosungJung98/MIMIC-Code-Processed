DROP TABLE IF EXISTS {mimic_derived}.pivoted_uo;

CREATE TABLE {mimic_derived}.pivoted_uo (
  icustay_id integer,
  charttime timestamp without time zone,
  urineoutput double precision
);
