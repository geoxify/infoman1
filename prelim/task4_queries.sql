-- =============================================================================
-- Course: INFOMAN1 — Relational Database Management
-- Assessment: Prelim Lab Exam — Task 4: Sample Data Queries (DQL with WHERE)
-- Student Name: Geoff Benedict P. Cariño
-- Student ID: 2511028
-- Database Name: toolshare_prelim
-- =============================================================================

USE toolshare_prelim;

-- -----------------------------------------------------------------------------
-- Query 1: List the names and categories of all tools in the "Power Tools" category.
-- -----------------------------------------------------------------------------
-- Explanation: Projects `tool_name` and `category` from the `tool` table, applying
-- an equality filter on the string column `category` matching 'Power Tools'.
SELECT tool_name, category
FROM tool
WHERE category = 'Power Tools';

/*
Execution Result:
+----------------+-------------+
| tool_name      | category    |
+----------------+-------------+
| Cordless Drill | Power Tools |
| Circular Saw   | Power Tools |
| Angle Grinder  | Power Tools |
+----------------+-------------+
3 rows in set (0.00 sec)
*/


-- -----------------------------------------------------------------------------
-- Query 2: Find all members who joined after January 1, 2025.
-- -----------------------------------------------------------------------------
-- Explanation: Filters rows in the `member` table where `join_date` is strictly
-- greater than the temporal literal '2025-01-01'.
SELECT member_id, member_name, phone, join_date
FROM member
WHERE join_date > '2025-01-01';

/*
Execution Result:
+-----------+-------------+-------------+------------+
| member_id | member_name | phone       | join_date  |
+-----------+-------------+-------------+------------+
|         2 | Jose Rizal   | 09179876543 | 2025-02-10 |
|         3 | Ana Reyes   | 09172223333 | 2025-06-01 |
|         5 | Liza Gomez  | 09175556666 | 2025-01-15 |
|         6 | Kevin Lim   | 09176667777 | 2025-08-05 |
+-----------+-------------+-------------+------------+
4 rows in set (0.00 sec)
*/


-- -----------------------------------------------------------------------------
-- Query 3: Show all borrowing records currently on loan (return_date IS NULL).
-- -----------------------------------------------------------------------------
-- Explanation: Queries the `borrowing` table for active loans. Because NULL indicates
-- the absence of a value (unknown/unreturned), standard comparison operators (= NULL)
-- evaluate to UNKNOWN under Three-Valued Logic. The special predicate `IS NULL` is required.
SELECT borrow_id, member_id, tool_id, borrow_date, return_date
FROM borrowing
WHERE return_date IS NULL;

/*
Execution Result:
+-----------+-----------+---------+-------------+-------------+
| borrow_id | member_id | tool_id | borrow_date | return_date |
+-----------+-----------+---------+-------------+-------------+
|         2 |         1 |       2 | 2025-09-12  | NULL        |
|         3 |         2 |       7 | 2025-09-05  | NULL        |
+-----------+-----------+---------+-------------+-------------+
2 rows in set (0.00 sec)
*/


-- -----------------------------------------------------------------------------
-- Query 4: List all borrowing records for one specific member ID.
-- -----------------------------------------------------------------------------
-- Explanation: Filters the `borrowing` table on foreign key `member_id = 1`
-- (corresponding to member Maria Santos in the sample dataset).
SELECT borrow_id, member_id, tool_id, borrow_date, return_date
FROM borrowing
WHERE member_id = 1;

/*
Execution Result:
+-----------+-----------+---------+-------------+-------------+
| borrow_id | member_id | tool_id | borrow_date | return_date |
+-----------+-----------+---------+-------------+-------------+
|         1 |         1 |       1 | 2025-09-01  | 2025-09-10  |
|         2 |         1 |       2 | 2025-09-12  | NULL        |
+-----------+-----------+---------+-------------+-------------+
2 rows in set (0.00 sec)
*/


-- -----------------------------------------------------------------------------
-- Query 5: List all tools purchased before January 1, 2024.
-- -----------------------------------------------------------------------------
-- Explanation: Filters the `tool` table using the strictly less-than operator (<)
-- against the ISO date literal '2024-01-01'.
SELECT tool_id, tool_name, category, purchase_date, location_code
FROM tool
WHERE purchase_date < '2024-01-01';

/*
Execution Result:
+---------+----------------+-------------+---------------+---------------+
| tool_id | tool_name      | category    | purchase_date | location_code |
+---------+----------------+-------------+---------------+---------------+
|       1 | Cordless Drill | Power Tools | 2023-05-10    | A3            |
|       2 | Circular Saw   | Power Tools | 2023-08-22    | A3            |
|       4 | Garden Shovel  | Garden      | 2023-12-01    | B1            |
+---------+----------------+-------------+---------------+---------------+
3 rows in set (0.00 sec)
*/
