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