-- This code extracts structured data from echocardiographies
-- You can join it to the text notes using ROW_ID
-- Just note that ROW_ID will differ across versions of MIMIC-III.
insert into {mimic_derived}.echo_data
select ROW_ID
  , subject_id, hadm_id
  , chartdate
  -- charttime is always null for echoes..
  -- however, the time is available in the echo text, e.g.:
  -- , substring(ne.text, 'Date/Time: [\[\]0-9*-]+ at ([0-9:]+)') as TIMESTAMP
  -- we can therefore impute it and re-create charttime
  , to_timestamp
  (
      to_char(chartdate, '%Y-%m-%d')
      || substring(ne.text from 'Date/Time: .+? at ([0-9]+:[0-9]{2})')
      || ':00',
      '%Y-%m-%d%H:%M:%S'
   ) AS charttime
  -- explanation of below substring:
  --  'Indication: ' - matched verbatim
  --  (.*?) - match any character
  --  \n - the end of the line
  -- substring only returns the item in ()s
  -- note: the '?' makes it non-greedy. if you exclude it, it matches until it reaches the *last* \n
  , substring(ne.text from 'Indication: (.*?)\n') as Indication
  -- sometimes numeric values contain de-id text, e.g. [** Numeric Identifier **]
  -- this removes that text
  , cast(substring(ne.text from 'Height: \\x28in\\x29 ([0-9]+)') as numeric) as Height
  , cast(substring(ne.text from 'Weight \\x28lb\\x29: ([0-9]+)\n') as numeric) as Weight
  , cast(substring(ne.text from 'BSA \\x28m2\\x29: ([0-9]+) m2\n') as numeric) as BSA -- ends in 'm2'
  , substring(ne.text from 'BP \\x28mm Hg\\x29: (.+)\n') as BP -- Sys/Dias
  , cast(substring(ne.text from 'BP \\x28mm Hg\\x29: ([0-9]+)/[0-9]+?\n') as numeric) as BPSys -- first part of fraction
  , cast(substring(ne.text from 'BP \\x28mm Hg\\x29: [0-9]+/([0-9]+?)\n') as numeric) as BPDias -- second part of fraction
  , cast(substring(ne.text from 'HR \\x28bpm\\x29: ([0-9]+?)\n') as numeric) as HR
  , substring(ne.text from 'Status: (.*?)\n') as Status
  , substring(ne.text from 'Test: (.*?)\n') as Test
  , substring(ne.text from 'Doppler: (.*?)\n') as Doppler
  , substring(ne.text from 'Contrast: (.*?)\n') as Contrast
  , substring(ne.text from 'Technical Quality: (.*?)\n') as TechnicalQuality
FROM {mimic_clinical}.noteevents ne
where category = 'Echo';
