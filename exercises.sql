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