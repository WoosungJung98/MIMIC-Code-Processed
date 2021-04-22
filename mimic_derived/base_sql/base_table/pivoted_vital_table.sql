DROP TABLE IF EXISTS {mimic_derived}.pivoted_vital;

CREATE TABLE {mimic_derived}.pivoted_vital (
  icustay_id integer,
  charttime timestamp without time zone,
  heartrate double precision,
  sysbp double precision,
  diasbp double precision,
  meanbp double precision,
  resprate double precision,
  tempc double precision,
  spo2 double precision,
  glucose double precision
);
