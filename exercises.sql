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

SELECT 
-- CASE or IF, THEN to print the individuals name and first letter of profession in parenthesis
    CASE
        WHEN (Occupation = "Doctor") THEN (Name) "(D)"
        WHEN (Occupation = "Professor") THEN (Name) "(P)"
        WHEN (Occupation = "Singer") THEN (Name) "(S)"
        WHEN (Occupation = "Actor") THEN (Name) "(A)"
        END as name_and_profession
    (CASE )
        
