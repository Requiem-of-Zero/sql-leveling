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

-- 
-- Lesson 6: Inner JOINS
-- movies
-- | id | title | director | year | length_minutes |
-- | 1 | Toy Story | John Lasseter | 1995 | 81 |
-- | 2 | A Bug's Life | John Lasseter | 1998 | 95 |
-- boxoffice
-- | movie_id | rating | domestic_sales | international_sales |
-- | 5 | 8.2 | 380843261 | 555900000 |
-- | 14 | 7.4 | 268492764 | 475066843 |

-- Find the domestic and international sales for each movie
-- Exercise 1
SELECT * 
FROM movies
INNER JOIN boxoffice ON id = movie_id
GROUP BY title;

-- Show the sales numbers for each movie that did better internationally rather than domestically
-- Exercise 2
SELECT * 
FROM movies
INNER JOIN boxoffice ON id = movie_id
WHERE international_sales > domestic_sales
GROUP BY title;

-- List all the movies by their ratings in descending order 
-- Exercise 3
SELECT * 
FROM movies
INNER JOIN boxoffice ON id = movie_id
ORDER BY rating DESC;

-- 
-- Lesson 7: Outer JOINS
-- buildings
-- | building_name | capacity |
-- | 1e | 24 |
-- | 1w | 32 |
-- employees
-- | role | name | building | years_employed |
-- | Engineer | Becky A. | 1e | 4 |
-- | Engineer | Dan B. | 1e | 2 |

-- Find the list of all buildings that have employees 
-- Exercise 1
SELECT *
FROM employees
LEFT JOIN buildings ON building_name = building
GROUP BY building_name;

-- Find the list of all buildings and their capacity 
-- Exercise 2
SELECT *
FROM buildings;

-- List all buildings and the distinct employee roles in each building (including empty buildings) 
-- Exercise 3
SELECT DISTINCT building_name, role 
FROM buildings 
  LEFT JOIN employees
    ON building_name = building;

-- 
-- Lesson 8: NULLS
-- buildings
-- | building_name | capacity |
-- | 1e | 24 |
-- | 1w | 32 |
-- employees
-- | role | name | building | years_employed |
-- | Engineer | Becky A. | 1e | 4 |
-- | Engineer | Dan B. | 1e | 2 |

-- Find the name and role of all employees who have not been assigned to a building 
-- Exercise 1
SELECT * 
FROM employees
WHERE building IS NULL;

-- Find the names of the buildings that hold no employees 
-- Exercise 2
SELECT * 
FROM buildings
LEFT JOIN employees ON building_name = building
WHERE building IS NULL;

-- 
-- Lesson 9: Queries with Expressions
-- movies
-- | id | title | director | year | length_minutes |
-- | 1 | Toy Story | John Lasseter | 1995 | 81 |
-- | 2 | A Bug's Life | John Lasseter | 1998 | 95 |
-- boxoffice
-- | movie_id | rating | domestic_sales | international_sales |
-- | 5 | 8.2 | 380843261 | 555900000 |
-- | 14 | 7.4 | 268492764 | 475066843 |

-- List all movies and their combined sales in millions of dollars
-- Exercise 1
SELECT *, (domestic_sales + international_sales)/1000000 AS total_in_millions 
FROM movies
INNER JOIN boxoffice ON id = movie_id;

-- List all movies and their ratings in percent
-- Exercise 2
SELECT *, (rating)*10 AS rating_percentage 
FROM movies
INNER JOIN boxoffice ON id = movie_id;

-- List all movies that were released on even number years 
-- Exercise 3
SELECT *
FROM movies
INNER JOIN boxoffice ON id = movie_id
WHERE year%2=0;

-- 
-- Lesson 10: Queries with Aggregates (pt 1)

-- Find the longest time that an employee has been at the studio 
-- Exercise 1
SELECT MAX(years_employed)
FROM employees;

-- For each role, find the average number of years employed by employees in that role
-- Exercise 2
SELECT *, AVG(years_employed)
FROM employees
GROUP BY role;

-- Find the total number of employee years worked in each building 
-- Exercise 3
SELECT *, SUM(years_employed)
FROM employees
GROUP BY building;

-- 
-- Lesson 11: Queries with Aggregates (pt 2)

-- Find the number of Artists in the studio (without a HAVING clause) 
-- Exercise 1
SELECT *, COUNT(*) AS total
FROM employees
WHERE role = 'Artist';

-- Find the number of Employees of each role in the studio
-- Exercise 2
SELECT *, COUNT(*) AS total
FROM employees
GROUP BY role

-- Find the total number of years employed by all Engineers
-- Exercise 3
SELECT *, SUM(years_employed) AS total_num_years
FROM employees
WHERE role = 'Engineer'
GROUP BY role;

-- 
-- Lesson 12: Select Queries order of Execution: SFWGHOL

-- Find the number of movies each director has directed 
-- Exercise 1
SELECT *, COUNT(title) AS count_movies
FROM movies
GROUP BY director;

-- Find the total domestic and international sales that can be attributed to each director 
-- Exercise 2
SELECT director, SUM(domestic_sales)+SUM(international_sales) AS total_sales
FROM movies
INNER JOIN boxoffice ON id = movie_id
GROUP BY director;

-- 
-- Lesson 13: Inserting rows
-- Table 1: Movies (similar table lesson 9)
-- Table 2: Boxoffice (similar table lesson 9)

-- Add the studio's new production, Toy Story 4 to the list of movies (you can use any director) 
-- Exercise 1:
INSERT INTO movies
(id, title, director, year, length_minutes)
VALUES(4, 'Toy Story 4', 'Sam Wong', 2025, 85);

-- Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table.
-- Exercise 2
INSERT INTO boxoffice
(movie_id, rating, domestic_sales, international_sales)
VALUES(4, 8.7, 340000000, 270000000);