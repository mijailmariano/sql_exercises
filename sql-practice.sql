-- date: sunday, october 30th 2022

-- Update the patients table for the allergies column. 
-- If the patient's allergies is null then replace it with 'NKA'

UPDATE patients
    SET allergies = 'NKA'
        WHERE allergies IS NULL;

-- Show first name and last name concatinated into one column to show their full name.

-- concatenating the first name, space, last name - and aliasing the column as 'full name'
SELECT
  CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- Show first name, last name, and the full province name of each patient.
-- Example: 'Ontario' instead of 'ON'

SELECT
  first_name,
  last_name,
  province_name
FROM patients
  JOIN province_names ON province_names.province_id = patients.province_id; -- could also do this with the following syntax:
  -- JOIN province_names USING (province_id);


-- Show how many patients have a birth_date with 2010 as the birth year.

SELECT COUNT(*) AS total_patients -- counting all rows/observations in the table and aliasing this column as 'total patients' which represents the count of rows 
    FROM patients
        WHERE YEAR(birth_date) = 2010; -- WHERE (condition) using the 'YEAR()' function 