DROP TABLE IF EXISTS {mimic_derived}.echo_data;

CREATE TABLE {mimic_derived}.echo_data (
  row_id integer,
  subject_id integer,
  hadm_id integer,
  chartdate timestamp without time zone,
  charttime timestamp without time zone,
  indication text,
  height numeric,
  weight numeric,
  bsa numeric,
  bp text,
  bpsys numeric,
  bpdias numeric,
  hr numeric,
  status text,
  test text,
  doppler text,
  contrast text,
  technicalquality text
);
