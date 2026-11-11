-- =============================================================================
-- Course: Information Management 1 (INFOMAN1)
-- Term: Midterm — Week 8 Lab
-- Lab Topic: Employee Payroll Query Lab (Pattern Matching, Aggregation, GROUP BY, HAVING)
-- Database Name: infoman1_week8
-- Author: Geoff Benedict Cariño
-- Student ID: 2511028
-- GitHub Repository: https://github.com/geoxify/infoman1
-- Date: November 11, 2026
-- =============================================================================

CREATE DATABASE IF NOT EXISTS infoman1_week8;
USE infoman1_week8;

-- -----------------------------------------------------------------------------
-- SETUP & DATASET VERIFICATION
-- -----------------------------------------------------------------------------
-- Ensure the seed dataset (week08_seed.sql) is imported prior to executing queries.
-- Exactly 500 rows must be present in the employee table.
SELECT COUNT(*) AS total_dataset_rows FROM employee;


-- =============================================================================
-- TASK 1: Pattern Matching Basics (Difficulty: Easy)
-- =============================================================================

-- Task 1.1: Find all employees whose last name ends in 'ez' (LIKE '%ez')
-- Returns: emp_id, first_name, last_name (161 matching rows)
SELECT emp_id, first_name, last_name
FROM employee
WHERE last_name LIKE '%ez';

-- Task 1.2: Find all employees whose first name starts with 'Ma' (LIKE 'Ma%')
-- Returns: emp_id, first_name, department (112 matching rows)
SELECT emp_id, first_name, department
FROM employee
WHERE first_name LIKE 'Ma%';

-- Task 1.3a: Prove emp_code is exactly 5 characters starting with 'E' using '_' wildcards
-- Confirms all 500 rows match pattern 'E____'
SELECT COUNT(*) AS total_matching_emp_codes
FROM employee
WHERE emp_code LIKE 'E____';

-- Task 1.3b: Find employees whose emp_code has '0' as the third character (pattern 'E_0__')
-- Returns: emp_code, first_name, last_name (48 matching rows)
SELECT emp_code, first_name, last_name
FROM employee
WHERE emp_code LIKE 'E_0__';


-- =============================================================================
-- TASK 2: Basic Aggregation & NULL Handling (Difficulty: Medium)
-- =============================================================================

-- Task 2.1: Total employees vs. employees earning commission
-- Explains the gap of 148 NULL commission records (500 total vs. 352 commission earners)
SELECT 
    COUNT(*) AS total_employees,
    COUNT(commission) AS employees_with_commission
FROM employee;

-- Task 2.2: Total monthly company payroll across all employees
-- Computes the aggregate sum of base salaries (33,282,250.00)
SELECT SUM(salary) AS total_monthly_payroll
FROM employee;

-- Task 2.3: Average salary, earliest hire date, and latest hire date
-- Evaluates numeric mean and temporal extremes (Earliest: 2015-01-03, Latest: 2026-09-14)
SELECT 
    AVG(salary) AS average_salary,
    MIN(hire_date) AS earliest_hire_date,
    MAX(hire_date) AS latest_hire_date
FROM employee;

-- Task 2.4: Total compensation including commission (COALESCE NULL commission to 0)
-- Correctly prevents NULL propagation in arithmetic addition (Total: 35,387,750.00)
SELECT SUM(salary + COALESCE(commission, 0)) AS total_compensation
FROM employee;


-- =============================================================================
-- TASK 3: Grouping Data (Difficulty: Medium)
-- =============================================================================

-- Task 3.1: Per-department aggregation
-- Returns department, headcount, average salary, and distinct job titles
SELECT 
    department,
    COUNT(*) AS headcount,
    AVG(salary) AS avg_salary,
    COUNT(DISTINCT job_title) AS distinct_job_titles
FROM employee
GROUP BY department
ORDER BY department;

-- Task 3.2: Multi-column grouping by department and job_title
-- Returns headcount per unique role combination across all departments (15 groups)
SELECT 
    department,
    job_title,
    COUNT(*) AS headcount
FROM employee
GROUP BY department, job_title
ORDER BY department, job_title;


-- =============================================================================
-- TASK 4: Advanced Filtering with HAVING (Difficulty: Hard)
-- =============================================================================

-- Task 4.1: Filter departments whose average salary exceeds 70,000 threshold
-- Justification: Company average is 66,564.50. A 70,000 threshold isolates high-earning
-- departments (Finance: 79,513.04, Engineering: 75,160.00, Sales: 71,799.65) from
-- lower-earning operational units (HR: 62,610.00, Support: 44,028.57).
-- Must use HAVING because AVG(salary) is an aggregate metric evaluated post-grouping.
SELECT 
    department,
    AVG(salary) AS avg_salary
FROM employee
GROUP BY department
HAVING AVG(salary) > 70000
ORDER BY avg_salary DESC;

-- Task 4.2: Combined filtering: Active employees only, departments with > 50 active headcount
-- Demonstrates row-level filtering (WHERE status = 'Active') combined with post-group
-- aggregate filtering (HAVING COUNT(*) > 50).
SELECT 
    department,
    COUNT(*) AS active_headcount
FROM employee
WHERE status = 'Active'
GROUP BY department
HAVING COUNT(*) > 50
ORDER BY active_headcount DESC;
