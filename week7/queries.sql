-- =============================================================================
-- Course: Information Management 1 (INFOMAN1)
-- Term: Midterm — Week 7 Lab
-- Lab Topic: Functions, Aliases & Filtering (DQL)
-- Database Name: university_db
-- Author: Geoff Benedict Cariño
-- Student ID: 2511028
-- =============================================================================

USE university_db;

-- -----------------------------------------------------------------------------
-- SETUP VERIFICATION
-- -----------------------------------------------------------------------------
SHOW TABLES;
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS total_instructors FROM instructors;
SELECT COUNT(*) AS total_assignments FROM assignments;
SELECT COUNT(*) AS total_courses FROM courses;


-- =============================================================================
-- TASK 1: Complex Student Roster (Difficulty: Medium)
-- =============================================================================
-- Objective:
--   Retrieve first_name, last_name, and major of students who:
--     1. Major in 'Computer Science' or 'Information Technology' (using IN)
--     2. Last name begins with 'S' (using LIKE)
--     3. NOT enrolled in the 'Online' section (using NOT)
-- -----------------------------------------------------------------------------

SELECT first_name, last_name, major
FROM students
WHERE major IN ('Computer Science', 'Information Technology')
  AND last_name LIKE 'S%'
  AND NOT section = 'Online';


-- =============================================================================
-- TASK 2: Formatting Employee Data (Difficulty: Easy)
-- =============================================================================
-- Objective:
--   Produce a single column named `Instructor Details` combining:
--     - First initial, period, space, full last name
--     - Salary rounded to the nearest whole integer enclosed in parentheses
--     - Pattern: "J. Smith ($55001)"
--     - Applied functions: CONCAT, LEFT (or SUBSTRING), ROUND
--     - Output limited to the first 5 records
-- -----------------------------------------------------------------------------

-- Implementation using LEFT():
SELECT CONCAT(LEFT(first_name, 1), '. ', last_name, ' ($', ROUND(salary), ')') AS `Instructor Details`
FROM instructors
LIMIT 5;

-- Alternative implementation using SUBSTRING():
-- SELECT CONCAT(SUBSTRING(first_name, 1, 1), '. ', last_name, ' ($', ROUND(salary), ')') AS `Instructor Details`
-- FROM instructors
-- LIMIT 5;


-- =============================================================================
-- TASK 3: Project Deadline Analysis (Difficulty: Medium)
-- =============================================================================
-- Objective:
--   Calculate duration (in days) available to complete each assignment.
--     - Calculate difference between due_date and assigned_date
--     - Alias resulting column as `Days_To_Complete`
--     - Filter for duration strictly greater than 14 days
--     - Sort from longest duration to shortest (DESC)
-- -----------------------------------------------------------------------------

SELECT assignment_name,
       DATEDIFF(due_date, assigned_date) AS Days_To_Complete
FROM assignments
WHERE DATEDIFF(due_date, assigned_date) > 14
ORDER BY Days_To_Complete DESC;


-- =============================================================================
-- TASK 4: Comprehensive Data Audit (Difficulty: Hard)
-- =============================================================================
-- Objective:
--   Audit courses table for incomplete or specific types of entries.
--     - Return course_code, course_name, credits
--     - course_description is missing (IS NULL)
--       OR credits between 4 and 6 inclusive (BETWEEN)
--     - AND course_code contains 'ADV' anywhere (LIKE)
--     - Ordered alphabetically by course_name (ASC)
--     - Demonstrates explicit operator precedence via parentheses
-- -----------------------------------------------------------------------------

SELECT course_code, course_name, credits
FROM courses
WHERE (course_description IS NULL OR credits BETWEEN 4 AND 6)
  AND course_code LIKE '%ADV%'
ORDER BY course_name ASC;

-- Demonstration of operator precedence breakdown without parentheses:
-- The query below evaluates as A OR (B AND C), incorrectly matching non-ADV
-- courses that happen to have NULL descriptions (e.g., CS-101):
-- SELECT course_code, course_name, credits
-- FROM courses
-- WHERE course_description IS NULL OR credits BETWEEN 4 AND 6 AND course_code LIKE '%ADV%'
-- ORDER BY course_name ASC;
