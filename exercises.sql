-- SQL Exercises
-- Start: Tuesday, October 11th 2022

-- Query_001: the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
-- Your result cannot contain duplicates.

-- NOTES:
-- 'UNIQUE' METHOD - ensures there are no duplicate values stored in a particular column or a set of columns
-- 'DISTICT' KEYWORD - is used in the SELECT statement to fetch distinct rows from a table
-- 'LEFT' FUNCTION - extracts a number of characters from a string (starting from left): LEFT(string, number_of_chars)

-- SOLUTION
SELECT UNIQUE(CITY)
    FROM STATION
        WHERE LEFT(CITY, 1) IN ('A', 'E', 'I', 'O', 'U');


-- Query_002 the list of CITY names ending with vowels (a, e, i, o, u) from STATION. 
-- Your result cannot contain duplicates.

-- NOTES:
-- I CAN TRY A 'RIGHT' FUNCTION TO CHECK THE NUMBER OF CHARACTERS OF A STRING STARTING FROM THE RIGHT
-- ALSO KEEPING IN MIND THAT THE QUERY SEARCH IS CASE SENSITIVE, SO VOWELS SHOULD ALL BE LOWER CASE
-- WILL ALSO USE A 'DISTINCT' KEYWORD IN THE SELECT STATEMENT
-- "RIGHT" FUNCTION: extracts a number of characters from a string (starting from right): RIGHT(string, number_of_chars)

-- SOLUTION
SELECT DISTINCT CITY
    FROM STATION
        WHERE RIGHT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u');


-- Query_003 the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
-- Your result cannot contain duplicates.

-- NOTES:
-- COULD PROBABLY ALSO SOLVE THIS USING REGULAR EXPRESSION 'REGEXP' example: '^[AEIOU].*[aeiou]$'

-- SOLUTION
SELECT DISTINCT CITY 
    FROM STATION 
        WHERE LEFT(CITY, 1) IN ('A', 'E', 'I', 'O', 'U')
            AND
                RIGHT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u'); 


-- Query_004 the list of CITY names from STATION that do not start with vowels. 
-- Your result cannot contain duplicates.

-- NOTES:
-- USING THE 'NOT IN' CLAUSE TO CHECK AND ACCOMPLISH THIS TASK
-- WHERE 'NOT IN' IS EXPRESSION - 'DOES NOT EQUAL TO' OR 'IS NOT LIKE'

-- SOLUTION
SELECT DISTINCT CITY
    FROM STATION
        WHERE LEFT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U');


-- Query_005 the list of CITY names from STATION that do not end with vowels. 
-- Your result cannot contain duplicates.

-- SOLUTION
SELECT DISTINCT CITY
    FROM STATION
        WHERE RIGHT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u');


-- Query_006 the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
-- Your result cannot contain duplicates.

-- SOLUTION
SELECT DISTINCT CITY
    FROM STATION
        WHERE CITY NOT RLIKE '^[aeiou]'
            OR CITY NOT REGEXP '[aeiou]$'

----
-- date: wednesday, october 12th 2022

-- Query_007 the list of CITY names from STATION that do not start with vowels and do not end with vowels. 
-- Your result cannot contain duplicates.

SELECT DISTINCT CITY
    FROM STATION
        WHERE CITY NOT REGEXP '[aeiou]$'
            AND CITY NOT RLIKE '^[aeiou]';

-- Query_008 the Name of any student in STUDENTS who scored higher than 75 Marks. 
-- Order your output by the last three characters of each name. 
-- If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), 
-- secondary sort them by ascending ID.

SELECT Name
    FROM STUDENTS
        WHERE Marks > 75
            ORDER BY RIGHT(Name, 3), ID;


-- Query_009 Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

SELECT name
    FROM Employee
        ORDER BY name;

-----
-- DATE: Thursday, October 13th 2022

-- Query_010 Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. 
-- Output one of the following statements for each record in the table:

-- Equilateral: It's a triangle with  sides of equal length.
-- Isosceles: It's a triangle with sides of equal length.
-- Scalene: It's a triangle with  sides of differing lengths.
-- Not A Triangle: The given values of A, B, and C don't form a triangle.

-- using a "CASE" function/method
SELECT
    CASE
    WHEN ((A + B <= C) OR (B + C <= A) OR (A + C <= B)) THEN 'Not A Triangle'
    WHEN ((A = B) AND (B = C)) THEN 'Equilateral'
    WHEN ((A = B ) OR (B = C ) OR (C = A)) THEN 'Isosceles'
    ELSE 'Scalene'
    END
FROM TRIANGLES;

-- using "IF" "ELSE" statements
SELECT IF(A + B <= C OR B + C <= A OR A + C <= B, "Not A Triangle",
        IF(A = B AND B = C, "Equilateral",
        IF(A = B OR B = C OR A = C, "Isosceles", "Scalene")))
FROM TRIANGLES;

-- Generate the following two result sets:
'''
1. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical 
(i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
2. Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format
'''

(SELECT 
-- CASE or IF, THEN to print the individuals name and first letter of profession in parenthesis
    CASE
        WHEN (Occupation = "Doctor") THEN CONCAT(Name, "(D)")
        WHEN (Occupation = "Professor") THEN CONCAT(Name, "(P)")
        WHEN (Occupation = "Singer") THEN CONCAT(Name, "(S)")
        WHEN (Occupation = "Actor") THEN CONCAT(Name, "(A)")
        END AS TEXT
FROM OCCUPATIONS)
-- union all function to combine both created table expressions
UNION ALL
(SELECT CONCAT("There are a total of", " ", COUNT(Occupation), " ", LOWER(Occupation), "s.") AS TEXT
FROM OCCUPATIONS
GROUP BY Occupation)
ORDER BY TEXT ASC;  -- i am ordering both created tables expressions by the same alias, "TEXT" which will output both tables ordered in alphabetical/numerical ascending order

----
-- date: wednesday, october 26th 2022

-- Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. 
-- The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
-- Note: Print NULL when there are no more names corresponding to an occupation.

-- notes:
-- there are two (2) columns; Name and Occupation
-- ea. name is sorted alphabetically
-- columns in this order: Doctor, Professor, Singer, Actor
-- if the profession is not found, then Null -- continue to next name/profession
-- I need to 1. specify Occupation column order, and then pivot

SELECT
-- creating new column headers which are the occupations in the table
    Doctor,
    Professor,
    Singer,
    Actor
-- next, I want to create the total number of rows for ea. profession found in the table
-- these will act as the columns that are called at and that are referenced at the top of this query
FROM (
    SELECT
        NameOrder,
        max(CASE Occupation WHEN 'Doctor' then Name end) AS Doctor,
        max(CASE Occupation WHEN 'Professor' then Name end) AS Professor,
        max(CASE Occupation WHEN 'Singer' then Name end) AS Singer,
        max(CASE Occupation WHEN 'Actor' then Name end) AS Actor
    -- this is the 'FROM' statement that the above occupation name will referenced from
    FROM (
            SELECT
                Occupation,
                Name,
                ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY Name ASC) AS NameOrder
            FROM Occupations) AS NameLists
    -- group by the referenced occupation name order listed in the second* 'SELECT' statement
    GROUP BY NameOrder
    ) AS Names;



-- date: saturday, november 5th 2022
-- We define an employee's total earnings to be their monthly (salary x months) worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
-- Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as space-separated integers.

-- today earnings == salary x number of tenured moths at company
-- query 1: max today earnings for all employees
-- query 2: total number of employees who have the max total earnings
-- return max total earnins and total number of employees with this earnings

-- similar to a python/pandas 'value_counts()' function
-- 1. create a new column (salary*months) aliased as 'total_earnings'
-- 2. create a second column which is the count of all records/employees
-- 3. group by total_earnings which is the earnings and number of employee that have earned this amount
-- 4. order by the total_earnings amount in descending order (from highest-lowest)
-- 5. limit the query to only return the highest total-earnings value

SELECT (salary*months) AS total_earnings, COUNT(*)
FROM Employee
    GROUP BY total_earnings
        ORDER BY total_earnings DESC
            LIMIT 1;

'''Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of decimal places.
The sum of all values in LONG_W rounded to a scale of decimal places.'''

-- the sum of all values in lat_n rounded to a scale of 2 decimal places
-- the sum of all values in long_w rounded to a scale of 2 decimal places

SELECT ROUND(SUM(LAT_N), 2) AS "lat",
            ROUND(SUM(LONG_W), 2) AS "lon"
FROM STATION;

-- Query the sum of Northern Latitudes (LAT_N) from STATION 
-- having values greater than 38.7880 and less than 137.2345. 
-- Truncate your answer to 4 decimal places.

-- may require a round and sum function 
-- additionally, will need to use a "where" function to filter for 
-- values in between two distinct points

SELECT ROUND(SUM(LAT_N), 4)
FROM STATION
    WHERE LAT_N BETWEEN 38.7880 AND 137.2345;

-- Query the greatest value of the Northern Latitudes (LAT_N) 
-- from STATION that is less than 137.2345. Truncate your answer to 4 decimal places.

SELECT ROUND(LAT_N, 4)
FROM STATION
    WHERE LAT_N < 137.2345
        ORDER BY LAT_N DESC
            LIMIT 1;


-- date: friday, november 25 2022
-- Q1: Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345
-- Round your answer to 4 decimal places

SELECT ROUND(LONG_W, 4)
FROM STATION
    WHERE LAT_N < 137.2345
        ORDER BY LAT_N DESC
            LIMIT 1;

-- Q2: Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780
-- Round your answer to 4 decimal places

SELECT ROUND(LAT_N, 4)
FROM STATION
    WHERE LAT_N > 38.7780
        ORDER BY LAT_N ASC
            LIMIT 1;

-- Q3: Query the Western Longitude (LONG_W) 
-- where the smallest Northern Latitude (LAT_N) in STATION is greater than 37.7780
-- Round your answer to 4 decimal places

SELECT ROUND(LONG_W, 4)
FROM STATION 
    WHERE LAT_N > 38.7780
    -- will order the results starting with the smallest LAT_N and working up to the largest
        ORDER BY LAT_N ASC
            LIMIT 1;


-- Q3:
'''Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.

a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
d happens to equal the maximum value in Western Longitude (LONG_W in STATION).

Query the Manhattan Distance between P1 and P2 points
and and round it to a scale of 4 decimal places.'''

-- where a == min(LAT_N)
-- where b == min(LONG_W)
-- where c == max(LAT_N)
-- where d == max(LONG_W)

-- manhattan distance is equal to (X1 - X2) + (Y1 - Y2)
-- therefore, (a - c) + (b - d)

SELECT 
    -- where we can return the absolute 'distance' value using MYSQL 'ABS()' function
    ABS(ROUND(((MIN(LAT_N) - MAX(LAT_N)) + (MIN(LONG_W) - MAX(LONG_W))), 4))
FROM STATION;


-- date: wednesday, november 30th 2022
-- Q1:
-- Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
-- Input Format
-- The CITY and COUNTRY tables are described as follows: 

SELECT SUM(CITY.POPULATION) AS "Asia_Total_Population"
    FROM CITY 
-- (inner join bc -- only want to return rows with matching values in the country id column)
        INNER JOIN COUNTRY
            ON CITY.COUNTRYCODE = COUNTRY.CODE
                WHERE COUNTRY.CONTINENT = "Asia";

-- Q2:
SELECT CITY.NAME 
    FROM CITY
-- using the nutural "JOIN" as an inner join
        JOIN COUNTRY
            ON CITY.COUNTRYCODE = COUNTRY.CODE
                WHERE COUNTRY.CONTINENT = "Africa";

-- Q3:
-- Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
-- Input Format
-- The CITY and COUNTRY tables are described as follows: 


-- we may be able to use a "GROUP BY" function to accomplish this question
-- let's start by calculating the average city population number and rounding this to a whole number
SELECT COUNTRY.CONTINENT AS "Continent",
    FLOOR(AVG(CITY.POPULATION)) AS "Average_City_Population"
    FROM CITY
        INNER JOIN COUNTRY
            ON CITY.COUNTRYCODE = COUNTRY.CODE
                GROUP BY COUNTRY.CONTINENT 


-- You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks(last question)