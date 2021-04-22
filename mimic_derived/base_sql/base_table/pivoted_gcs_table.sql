DROP TABLE IF EXISTS {mimic_derived}.pivoted_gcs;

CREATE TABLE {mimic_derived}.pivoted_gcs (
  icustay_id integer,
  charttime timestamp without time zone,
  gcs double precision,
  gcsmotor double precision,
  gcsverbal double precision,
  gcseyes double precision,
  endotrachflag integer
);
