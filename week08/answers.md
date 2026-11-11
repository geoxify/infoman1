# INFOMAN1 — Week 8 Lab Answers

Name: Geoff Benedict Cariño  
Student ID: 2511028  
GitHub repo: https://github.com/geoxify/infoman1  
Date submitted: November 11, 2026  

**Dataset check:** `SELECT COUNT(*) FROM employee;` returned: **500**

![Database Setup Verification](screenshots/db_setup.png)

```text
mysql> CREATE DATABASE IF NOT EXISTS infoman1_week8;
Query OK, 1 row affected (0.00 sec)

mysql> USE infoman1_week8;
Database changed

mysql> SOURCE week08_seed.sql;
Query OK, 0 rows affected (0.01 sec)
Query OK, 0 rows affected (0.02 sec)
Query OK, 500 rows affected (0.04 sec)
Records: 500  Duplicates: 0  Warnings: 0

mysql> SELECT COUNT(*) FROM employee;
+----------+
| COUNT(*) |
+----------+
|      500 |
+----------+
1 row in set (0.00 sec)
```

---

## Task 1 — Pattern Matching Basics

**Approach / explanation:**
To complete this task, I applied SQL pattern-matching predicates using the `LIKE` operator along with the `%` and `_` wildcards against string columns in the `employee` table. For Task 1.1 and 1.2, I utilized the `%` wildcard to filter for last names ending with the `'ez'` suffix (`LIKE '%ez'`) and first names beginning with the `'Ma'` prefix (`LIKE 'Ma%'`), returning the exact requested attribute projections. For Task 1.3, I leveraged the fixed-width single-character wildcard `_` to first confirm that every `emp_code` adheres strictly to an 'E' followed by four alphanumeric characters (`LIKE 'E____'`), which matched all 500 records, and then isolated codes possessing `'0'` at the third character position (`LIKE 'E_0__'`).

**Code / query used (if applicable):**
```sql
-- 1.1: Find all employees whose last name ends in 'ez'
SELECT emp_id, first_name, last_name
FROM employee
WHERE last_name LIKE '%ez';

-- 1.2: Find all employees whose first name starts with 'Ma'
SELECT emp_id, first_name, department
FROM employee
WHERE first_name LIKE 'Ma%';

-- 1.3a: Prove emp_code always holds exactly 5 characters starting with 'E'
SELECT COUNT(*) AS total_matching
FROM employee
WHERE emp_code LIKE 'E____';

-- 1.3b: Find employees whose emp_code has '0' as the third character
SELECT emp_code, first_name, last_name
FROM employee
WHERE emp_code LIKE 'E_0__';
```

**Evidence (screenshot filename, output, or file reference in this folder):**
![Task 1 Screenshot](screenshots/task1.png)

```text
mysql> -- Task 1.1: Find all employees whose last name ends in 'ez' (LIKE '%ez')
mysql> SELECT emp_id, first_name, last_name
    -> FROM employee
    -> WHERE last_name LIKE '%ez'
    -> LIMIT 8;
+--------+------------+-----------+
| emp_id | first_name | last_name |
+--------+------------+-----------+
|      1 | Mario      | Gutierrez |
|      2 | Rico       | Jimenez   |
|     16 | Bianca     | Velasquez |
|     17 | Ana        | Gomez     |
|     21 | Mavis      | Perez     |
|     27 | Kevin      | Gomez     |
|     28 | Felix      | Gomez     |
|     29 | Gabriel    | Gomez     |
+--------+------------+-----------+
8 rows in set (0.00 sec) -- Note: Exactly 161 total rows match LIKE '%ez'

mysql> -- Task 1.2: Find all employees whose first name starts with 'Ma' (LIKE 'Ma%')
mysql> SELECT emp_id, first_name, department
    -> FROM employee
    -> WHERE first_name LIKE 'Ma%'
    -> LIMIT 6;
+--------+------------+-------------+
| emp_id | first_name | department  |
+--------+------------+-------------+
|      1 | Mario      | Sales       |
|      3 | Mavis      | Sales       |
|      5 | Manuel     | Sales       |
|      7 | Marlon     | Engineering |
|     13 | Marisol    | Finance     |
|     20 | Mae        | HR          |
+--------+------------+-------------+
6 rows in set (0.00 sec) -- Note: Exactly 112 total rows match LIKE 'Ma%'

mysql> -- Task 1.3: Validate 5-char code pattern ('E____') and 3rd char '0' ('E_0__')
mysql> SELECT COUNT(*) FROM employee WHERE emp_code LIKE 'E____';
+----------+
| COUNT(*) |
+----------+
|      500 |
+----------+
1 row in set (0.00 sec) -- Proof: All 500 rows adhere to the 5-character format starting with 'E'

mysql> SELECT emp_code, first_name, last_name FROM employee WHERE emp_code LIKE 'E_0__' LIMIT 5;
+----------+------------+-----------+
| emp_code | first_name | last_name |
+----------+------------+-----------+
| E9042    | Isabel     | Cruz      |
| E1041    | John       | Navarro   |
| E9032    | Leo        | Tolentino |
| E6062    | Jacob      | Morales   |
| E7043    | Matthew    | Jimenez   |
+----------+------------+-----------+
5 rows in set (0.00 sec) -- Note: Exactly 48 rows match LIKE 'E_0__'
```

- **Row counts summary:**
  - Task 1.1 (`last_name LIKE '%ez'`): **161 rows**
  - Task 1.2 (`first_name LIKE 'Ma%'`): **112 rows**
  - Task 1.3a (`emp_code LIKE 'E____'`): **500 rows** (100% of the dataset)
  - Task 1.3b (`emp_code LIKE 'E_0__'`): **48 rows**

**Reflection question:**
_[Why do we use the `%` wildcard instead of the `_` wildcard when searching for fields containing a specific keyword?]_

We use the `%` wildcard rather than the `_` wildcard because keywords typically appear within text strings of variable, unpredictable lengths and unknown character offsets. The `%` wildcard matches any sequence of zero, one, or multiple characters (e.g., `LIKE '%keyword%'`), enabling robust substring matching regardless of where the keyword resides or how many characters precede or follow it. Conversely, the underscore (`_`) wildcard enforces an exact, rigid one-to-one character match per occurrence, requiring the query author to know the exact positional offset and fixed total character length beforehand; using `_` for general keyword searches would fail whenever a field possesses even one extra or missing character.

---

## Task 2 — Basic Aggregation

**Approach / explanation:**
I executed table-level summary calculations against the entire `employee` dataset without a `GROUP BY` clause, applying ANSI SQL aggregate functions including `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`. To address Task 2.1, I contrasted `COUNT(*)` against `COUNT(commission)` to identify the headcount gap created by non-commissioned roles. In Task 2.2 and 2.3, I computed the total monthly payroll, the mean employee salary, and the historical temporal boundaries of the company via `MIN(hire_date)` and `MAX(hire_date)`. Finally, for Task 2.4, I integrated `COALESCE(commission, 0)` inside the arithmetic sum to prevent `NULL` propagation from nullifying base salaries during total compensation aggregation.

**Code / query used (if applicable):**
```sql
-- 2.1: Total employees vs. employees earning commission
SELECT 
    COUNT(*) AS total_employees,
    COUNT(commission) AS employees_with_commission
FROM employee;

-- 2.2: Total monthly payroll: SUM(salary)
SELECT SUM(salary) AS total_monthly_payroll
FROM employee;

-- 2.3: AVG salary, earliest hire date, and latest hire date
SELECT 
    AVG(salary) AS average_salary,
    MIN(hire_date) AS earliest_hire_date,
    MAX(hire_date) AS latest_hire_date
FROM employee;

-- 2.4: Total compensation including commission (treating NULL as zero)
SELECT SUM(salary + COALESCE(commission, 0)) AS total_compensation
FROM employee;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
![Task 2 Screenshot](screenshots/task2.png)

```text
mysql> -- Task 2.1: Total employees vs. employees earning commission
mysql> SELECT COUNT(*) AS total_employees, COUNT(commission) AS employees_with_commission
    -> FROM employee;
+-----------------+---------------------------+
| total_employees | employees_with_commission |
+-----------------+---------------------------+
|             500 |                       352 |
+-----------------+---------------------------+
1 row in set (0.00 sec)

mysql> -- Task 2.2: Total monthly payroll: SUM(salary)
mysql> SELECT SUM(salary) AS total_monthly_payroll
    -> FROM employee;
+-----------------------+
| total_monthly_payroll |
+-----------------------+
|           33282250.00 |
+-----------------------+
1 row in set (0.00 sec)

mysql> -- Task 2.3: AVG salary, earliest & latest hire dates
mysql> SELECT AVG(salary) AS average_salary,
    ->        MIN(hire_date) AS earliest_hire_date,
    ->        MAX(hire_date) AS latest_hire_date
    -> FROM employee;
+----------------+--------------------+------------------+
| average_salary | earliest_hire_date | latest_hire_date |
+----------------+--------------------+------------------+
|   66564.500000 | 2015-01-03         | 2026-09-14       |
+----------------+--------------------+------------------+
1 row in set (0.00 sec)

mysql> -- Task 2.4: Total compensation including commission (COALESCE NULL to 0)
mysql> SELECT SUM(salary + COALESCE(commission, 0)) AS total_compensation
    -> FROM employee;
+--------------------+
| total_compensation |
+--------------------+
|        35387750.00 |
+--------------------+
1 row in set (0.00 sec)
```

- **Explanation of the Task 2.1 Gap:**
  The 148-row difference between `COUNT(*)` (500) and `COUNT(commission)` (352) occurs because `COUNT(*)` tallies all physical rows in the relation, whereas `COUNT(column_name)` tallies only records where the specified column contains a non-NULL value. In this dataset, exactly 148 employees occupy job roles that do not earn commissions, leaving their `commission` attribute as `NULL`.
- **Why `COALESCE` was needed in Task 2.4:**
  Under SQL Three-Valued Logic (3VL), any arithmetic operation involving a `NULL` operand yields `NULL` (`salary + NULL = NULL`). Without `COALESCE(commission, 0)`, the 148 employees with `NULL` commission would evaluate to a `NULL` individual compensation, and because `SUM()` discards `NULL` values during aggregation, their entire base salaries would have been completely omitted from the total payroll. `COALESCE(commission, 0)` safely substitutes `0.00` for missing commissions, ensuring every employee's base salary is properly preserved in the cumulative aggregate sum.

**Reflection question:**
_[What is the difference between `COUNT(*)` and `COUNT(column_name)`?]_

The primary distinction lies in their handling of missing values (`NULL`):
1. **`COUNT(*)` evaluates row cardinality:** It counts every tuple that satisfies the query conditions, regardless of whether individual columns contain `NULL` or actual data. It represents the absolute record count of the table or partition.
2. **`COUNT(column_name)` evaluates attribute completeness:** It inspects the specified column for each qualifying row and strictly tallies only non-NULL entries, entirely skipping rows where that column evaluates to `NULL`.
3. **Performance & Optimization:** Because `COUNT(*)` only requires tracking row existence, query optimizers can fulfill it using the smallest available secondary index without reading data pages. In contrast, `COUNT(column_name)` requires verifying column nullability, necessitating access to the specific attribute data.

---

## Task 3 — Grouping Data

**Approach / explanation:**
I used the `GROUP BY` clause to partition the 500 employee records into logical summary categories and computed per-group aggregate metrics. For Task 3.1, I grouped by `department` to return the headcount (`COUNT(*)`), the departmental average salary (`AVG(salary)`), and the diversity of roles using `COUNT(DISTINCT job_title)`. For Task 3.2, I expanded the grouping hierarchy by applying multi-column grouping across `department` and `job_title`, breaking down headcounts per specific job title within each organizational division across 15 distinct combinations.

**Code / query used (if applicable):**
```sql
-- 3.1: Per-department headcount, average salary, and distinct job titles
SELECT 
    department,
    COUNT(*) AS headcount,
    AVG(salary) AS avg_salary,
    COUNT(DISTINCT job_title) AS distinct_job_titles
FROM employee
GROUP BY department
ORDER BY department;

-- 3.2: Multi-column grouping: headcount per department and job title
SELECT 
    department,
    job_title,
    COUNT(*) AS headcount
FROM employee
GROUP BY department, job_title
ORDER BY department, job_title;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
![Task 3 Screenshot](screenshots/task3.png)

```text
mysql> -- Task 3.1: Per department headcount, avg salary, and distinct job titles
mysql> SELECT department,
    ->        COUNT(*) AS headcount,
    ->        AVG(salary) AS avg_salary,
    ->        COUNT(DISTINCT job_title) AS distinct_job_titles
    -> FROM employee
    -> GROUP BY department;
+-------------+-----------+--------------+---------------------+
| department  | headcount | avg_salary   | distinct_job_titles |
+-------------+-----------+--------------+---------------------+
| Engineering |       125 | 75160.000000 |                   3 |
| Finance     |        69 | 79513.043478 |                   3 |
| HR          |        50 | 62610.000000 |                   3 |
| Sales       |       144 | 71799.652778 |                   3 |
| Support     |       112 | 44028.571429 |                   3 |
+-------------+-----------+--------------+---------------------+
5 rows in set (0.00 sec)

mysql> -- Task 3.2: Multi-column grouping: headcount per department and job_title
mysql> SELECT department, job_title, COUNT(*) AS headcount
    -> FROM employee
    -> GROUP BY department, job_title;
+-------------+----------------------+-----------+
| department  | job_title            | headcount |
+-------------+----------------------+-----------+
| Engineering | DevOps Engineer      |        42 |
| Engineering | QA Analyst           |        39 |
| Engineering | Software Engineer    |        44 |
| Finance     | Accountant           |        21 |
| Finance     | Finance Manager      |        24 |
| Finance     | Financial Analyst    |        24 |
| HR          | HR Manager           |        18 |
| HR          | HR Specialist        |        20 |
| HR          | Recruiter            |        12 |
| Sales       | Account Manager      |        50 |
| Sales       | Sales Manager        |        49 |
| Sales       | Sales Representative |        45 |
| Support     | Support Agent        |        40 |
| Support     | Support Lead         |        29 |
| Support     | Support Specialist   |        43 |
+-------------+----------------------+-----------+
15 rows in set (0.00 sec)
```

**Reflection question:**
_[Why is it generally invalid to include columns in the `SELECT` list that are not in the `GROUP BY` clause, unless they are inside an aggregate function?]_

In relational database processing, a `GROUP BY` clause collapses multiple rows that share the same group key into a single consolidated summary row. If a non-aggregated attribute that is not part of the `GROUP BY` clause is included in the `SELECT` projection, a cardinality mismatch occurs: the group contains many candidate values for that column, making it logically indeterminate which single value the database should select. To uphold relational determinism and prevent arbitrary, unpredictable query results, the ANSI SQL standard (enforced in MySQL via the `ONLY_FULL_GROUP_BY` SQL mode) strictly rejects queries containing unaggregated, non-grouped columns unless wrapped in an aggregate function (e.g. `SUM`, `AVG`, `MIN`, `MAX`) that defines how those multiple values are mathematically synthesized into a single scalar value.

---

## Task 4 — Advanced Filtering with HAVING

**Approach / explanation:**
I formulated post-aggregation filtering queries using the `HAVING` clause to filter summarized groups rather than individual candidate rows. For Task 4.1, after inspecting the department salary averages from Task 3.1 and noting a company-wide mean of 66,564.50, I established an analytical threshold of 70,000.00 to isolate departments whose compensation exceeds the corporate baseline. For Task 4.2, I combined row-level pre-filtering with group-level post-filtering by first eliminating non-active employees with `WHERE status = 'Active'`, grouping the survivors by `department`, and then applying `HAVING COUNT(*) > 50` to restrict the final projection to departments maintaining more than 50 active personnel.

**Threshold Selection and Justification (Task 4.1):**
- **Chosen Threshold:** `70000.00`
- **Data Inspection Findings:**
  - `Finance`: 79,513.04
  - `Engineering`: 75,160.00
  - `Sales`: 71,799.65
  - `Company-Wide Mean`: 66,564.50
  - `HR`: 62,610.00
  - `Support`: 44,028.57
- **Justification:** The company-wide average salary across all 500 employees is 66,564.50. Setting the threshold at 70,000.00 creates a meaningful analytical cutoff that isolates the top-tier revenue-generating and technical divisions (`Finance`, `Engineering`, and `Sales`) that exceed the company average, while excluding operational support and administrative units (`HR` and `Support`) that fall below this benchmark.

**Code / query used (if applicable):**
```sql
-- 4.1: Departments whose average salary exceeds the 70,000 threshold
SELECT 
    department,
    AVG(salary) AS avg_salary
FROM employee
GROUP BY department
HAVING AVG(salary) > 70000;

-- 4.2: Combined query: Active employees only, departments with > 50 active employees
SELECT 
    department,
    COUNT(*) AS active_headcount
FROM employee
WHERE status = 'Active'
GROUP BY department
HAVING COUNT(*) > 50;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
![Task 4 Screenshot](screenshots/task4.png)

```text
mysql> -- Task 4.1: Departments with avg salary > 70000 threshold (using HAVING)
mysql> SELECT department, AVG(salary) AS avg_salary
    -> FROM employee
    -> GROUP BY department
    -> HAVING AVG(salary) > 70000;
+-------------+--------------+
| department  | avg_salary   |
+-------------+--------------+
| Engineering | 75160.000000 |
| Finance     | 79513.043478 |
| Sales       | 71799.652778 |
+-------------+--------------+
3 rows in set (0.00 sec)

mysql> -- Task 4.2: Departments with > 50 Active employees (WHERE + GROUP BY + HAVING)
mysql> SELECT department, COUNT(*) AS active_headcount
    -> FROM employee
    -> WHERE status = 'Active'
    -> GROUP BY department
    -> HAVING COUNT(*) > 50;
+-------------+------------------+
| department  | active_headcount |
+-------------+------------------+
| Engineering |              104 |
| Finance     |               52 |
| Sales       |              116 |
| Support     |               99 |
+-------------+------------------+
4 rows in set (0.00 sec)
```

- **Explanation of why `HAVING` was required instead of `WHERE`:**
  - **Query 4.1:** `HAVING` was required because the filtering criterion `AVG(salary) > 70000` evaluates an aggregate calculation across grouped sets of rows; the `WHERE` clause executes before grouping occurs and cannot evaluate aggregate summary functions.
  - **Query 4.2:** `HAVING` was required for `COUNT(*) > 50` because the headcount condition evaluates an aggregate metric computed on groups of records, whereas `WHERE` is strictly constrained to filtering individual row attributes (e.g. `status = 'Active'`) prior to group aggregation.

**Reflection question:**
_[Why must we use the `HAVING` clause here instead of the `WHERE` clause to filter by the average value?]_

We must use `HAVING` instead of `WHERE` because of SQL's strict logical query processing order: `FROM` $\rightarrow$ `WHERE` $\rightarrow$ `GROUP BY` $\rightarrow$ `HAVING` $\rightarrow$ `SELECT` $\rightarrow$ `ORDER BY`. The `WHERE` clause is evaluated row-by-row before any grouping or aggregation takes place; at that stage, aggregate values like `AVG(salary)` do not yet exist in memory. The `HAVING` clause was specifically designed to evaluate predicates on synthesized group summaries produced by aggregate functions after the `GROUP BY` step has executed. Attempting to place an aggregate function like `AVG()` inside a `WHERE` clause violates this lifecycle and triggers a syntax error (`ERROR 1111 (HY000): Invalid use of group function`).

---

## Self-Check

- [x] All tasks committed with individual, meaningful commit messages
- [x] All files placed inside `week08/`
- [x] This file completed and renamed `answers.md`
- [x] Repository link pasted into Moodle (no files uploaded)
