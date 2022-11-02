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


-- date: tuesday, november 1st 2022
-- Show the first_name, last_name, and height of the patient with the greatest height.

SELECT
	first_name, 
  last_name, 
  height
  FROM patients
    ORDER BY height DESC
LIMIT 1;

-- Show first name, last name, and gender of patients who's gender is 'M'

SELECT
	first_name, 
    last_name,
    gender
FROM patients 
where gender = 'M';

-- date: wednesday, november 2nd 2022

-- Query a count of the number of cities in CITY having a Population larger than 100_000
-- 1.
SELECT COUNT(NAME)
FROM CITY
WHERE POPULATION > 100000;

-- 2.
-- Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.

SELECT SUM(POPULATION)
FROM CITY
WHERE COUNTRYCODE = "JPN";

-- 3. 
-- Query the difference between the maximum and minimum populations in CITY.

SELECT (MAX(POPULATION) - MIN(POPULATION)) AS "POP_RANGE"
FROM CITY;

-- 4. 
-- Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's
-- key was broken until after completing the calculation. 
-- She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
-- Write a query calculating the amount of error (i.e. ACTUAL - MISCALCULATED)
-- average monthly salaries), and round it up to the next integer.

-- notes:
-- 'rounding up' will require a 'ceiling' function to move up in intergers; regardless of remaining irrational number (i.e., 8.3 --> 9.0)
-- 1. calculate the 'true salary average'
-- 2. create the 'miscalculation' values --> replacing all '0' numbers with blank 
-- 3. calculate the average for the miscalculation values and subtract this from the true average 
-- 4. return calculated 'total error' number

SELECT CEIL(AVG(Salary) - AVG(REPLACE(Salary, '0', ''))) AS 'TOTAL_ERROR'
FROM EMPLOYEES;

