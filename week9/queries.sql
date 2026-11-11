-- =============================================================================
-- Course: Information Management 1 (INFOMAN1) — Midterm, Week 9
-- Topic: SQL Joins (INNER JOIN, LEFT JOIN, Multi-Table Joins, and Outer-Join Filters)
-- Student Name: Geoff Benedict Cariño
-- Student ID: 2511028
-- GitHub Repository: https://github.com/geoxify/infoman1
-- Date Submitted: November 11, 2026
-- =============================================================================

USE infoman1_canteen;

-- =============================================================================
-- Task 1 — INNER JOIN Basics (Easy)
-- Prompt: Write a query that lists each buyer's student_name, program, order_id,
-- and order_date using INNER JOIN between students and orders on the student
-- identifier. Order by order_id.
-- =============================================================================

SELECT 
    s.student_name,
    s.program,
    o.order_id,
    o.order_date
FROM students s
INNER JOIN orders o 
    ON s.student_id = o.student_id
ORDER BY o.order_id;


-- =============================================================================
-- Task 2 — Finding Missing Relationships (Easy/Medium)
-- =============================================================================

-- Query 2(a): LEFT JOIN listing every student with matched orders (NULL if none)
SELECT 
    s.student_name,
    s.program,
    o.order_id,
    o.order_date
FROM students s
LEFT JOIN orders o 
    ON s.student_id = o.student_id
ORDER BY s.student_id, o.order_id;

-- Query 2(b): Same join filtered with WHERE o.order_id IS NULL for non-buyers
-- Note: Returns Ben Lim (BSCS) and Cara Yu (BSIS) because their student_ids
-- have no corresponding records in the orders table.
SELECT 
    s.student_name,
    s.program,
    o.order_id,
    o.order_date
FROM students s
LEFT JOIN orders o 
    ON s.student_id = o.student_id
WHERE o.order_id IS NULL
ORDER BY s.student_id;


-- =============================================================================
-- Task 3 — Four-Table Canteen Report (Medium)
-- Prompt: Write one query joining students, orders, order_items, and menu_items
-- that returns student_name, program, order_id, item_name, quantity, price, and
-- (quantity * price) AS line_total, ordered by order_id, item_name.
-- Every JOIN must have its own ON key relationship, and shared columns must be
-- qualified with aliases.
-- =============================================================================

SELECT 
    s.student_name,
    s.program,
    o.order_id,
    m.item_name,
    oi.quantity,
    m.price,
    (oi.quantity * m.price) AS line_total
FROM students s
INNER JOIN orders o 
    ON s.student_id = o.student_id
INNER JOIN order_items oi 
    ON o.order_id = oi.order_id
INNER JOIN menu_items m 
    ON oi.menu_id = m.menu_id
ORDER BY o.order_id, m.item_name;


-- =============================================================================
-- Task 4 — Aliases, Filters, and the Silent Inner Join (Medium/Hard)
-- =============================================================================

-- Version 1: Filtered report for August 2026 orders (INNER JOIN)
-- Showing buyer, item, and line total, sorted newest first
SELECT 
    s.student_name,
    o.order_date,
    m.item_name,
    (oi.quantity * m.price) AS line_total
FROM students s
INNER JOIN orders o 
    ON s.student_id = o.student_id
INNER JOIN order_items oi 
    ON o.order_id = oi.order_id
INNER JOIN menu_items m 
    ON oi.menu_id = m.menu_id
WHERE o.order_date >= '2026-08-01'
ORDER BY o.order_date DESC, o.order_id DESC, m.item_name;

-- Version 2: The "Silent Inner Join" Demonstration
-- Starts from a LEFT JOIN but applies a WHERE filter on right-side attribute o.order_date.
-- Drops students without orders because NULL >= '2026-08-01' evaluates to UNKNOWN.
SELECT 
    s.student_name,
    s.program,
    o.order_id,
    o.order_date,
    m.item_name,
    (oi.quantity * m.price) AS line_total
FROM students s
LEFT JOIN orders o 
    ON s.student_id = o.student_id
LEFT JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN menu_items m 
    ON oi.menu_id = m.menu_id
WHERE o.order_date >= '2026-08-01'
ORDER BY o.order_date DESC, s.student_name;

-- Version 3 (The Recommended Fix): Move date filter to the ON clause
-- Preserves all students (including Ben Lim and Cara Yu) by filtering the join candidate
-- rows before unmatched left rows are padded with NULLs.
SELECT 
    s.student_name,
    s.program,
    o.order_id,
    o.order_date,
    m.item_name,
    (oi.quantity * m.price) AS line_total
FROM students s
LEFT JOIN orders o 
    ON s.student_id = o.student_id 
    AND o.order_date >= '2026-08-01'
LEFT JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN menu_items m 
    ON oi.menu_id = m.menu_id
ORDER BY o.order_date DESC, s.student_name;

-- Version 3b (Alternative Fix): Accommodate NULL explicitly in WHERE
SELECT 
    s.student_name,
    s.program,
    o.order_id,
    o.order_date,
    m.item_name,
    (oi.quantity * m.price) AS line_total
FROM students s
LEFT JOIN orders o 
    ON s.student_id = o.student_id
LEFT JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN menu_items m 
    ON oi.menu_id = m.menu_id
WHERE o.order_date >= '2026-08-01' 
   OR o.order_id IS NULL
ORDER BY o.order_date DESC, s.student_name;
