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