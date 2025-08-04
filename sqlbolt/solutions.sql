-- SQL Bolt lessions: https://sqlbolt.com/
-- Notion Documentation: https://www.notion.so/Week-1-Test-Fundamentals-SQL-244d4052ac0380c198f0d82dd6895f7f?source=copy_link
-- Lesson 4 Exercises
-- Exercise 1
SELECT *
FROM movies
ORDER BY year ASC
LIMIT 4;

-- Exercise 2
SELECT *
FROM movies
ORDER BY year DESC
LIMIT 4;

-- Exercise 3
SELECT *
FROM movies
ORDER BY title ASC
LIMIT 5;

-- Exercise 4
SELECT *
FROM movies
ORDER BY title ASC
LIMIT 5 OFFSET 5;

-- 
-- Lesson 5
-- | city | country | population | latitude | longitude |
-- | Toronto | Canada | 2795060 | 43.653226 | -79.383184 |
-- | Montreal | Canada | 1717767 | 45.501689 | -73.567256 |
-- List all the Canadian cities and their populations
-- Exercise 1
SELECT * 
FROM north_american_cities
WHERE country = 'Canada';

-- Order all the cities in the United States by their latitude from north to south 
-- Exercise 2
SELECT * 
FROM north_american_cities
WHERE country = 'United States'
ORDER BY latitude DESC;

-- List all the cities west of Chicago, ordered from west to east 
-- Exercise 3
SELECT *
FROM north_american_cities
WHERE longitude < -87.629798 -- a lower value longitude indicates more west
ORDER BY longitude ASC; -- ascending, lower number is first (most west to more east)

-- List the two largest cities in Mexico (by population) 
-- Exercise 4
SELECT *
FROM north_american_cities
WHERE country = 'Mexico'
ORDER BY population DESC
LIMIT 2;

-- List the third and fourth largest cities (by population) in the United States and their population 
-- Exercise 5
SELECT *
FROM north_american_cities
WHERE country = 'United States'
ORDER BY population DESC
LIMIT 2 OFFSET 2;