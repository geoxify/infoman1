-- =============================================================================
-- Course: Information Management 1 (INFOMAN1) — Midterm, Week 10
-- Topic: Safe DML & Data Integrity Practical Test
-- Student Name: Geoff Benedict Cariño
-- Student ID: 2511028
-- GitHub Repository: https://github.com/geoxify/infoman1
-- Date Submitted: November 12, 2026
-- =============================================================================

USE infoman1_bookstore;

-- =============================================================================
-- Task 1 — Safe INSERT (Easy, combines Topics 1 & 4)
-- Objective: Add two products to `products` listing target columns explicitly:
--   1. Scientific Calculator (CALC-SCI-001, 850.00, 20, Active)
--   2. Compass (CMP-001, 120.00, 50, Active)
-- Confirm each insert with a post-SELECT, and document one rejected insert.
-- =============================================================================

-- 1.1: Insert Scientific Calculator with explicit target columns
INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Scientific Calculator', 'CALC-SCI-001', 850.00, 20, 'Active');

-- 1.1b: Confirm Scientific Calculator insert via target SELECT
SELECT * 
FROM products 
WHERE product_id = 6;

-- 1.2: Insert Compass with explicit target columns
INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Compass', 'CMP-001', 120.00, 50, 'Active');

-- 1.2b: Confirm Compass insert via target SELECT
SELECT * 
FROM products 
WHERE product_id = 7;

-- 1.3: Verification of all catalog records (7 products total)
SELECT 
    product_id,
    product_name,
    sku,
    price,
    stock_quantity,
    status
FROM products
ORDER BY product_id;

-- 1.4: Rejected INSERT Demonstration 1 — Data Type Mismatch
-- MySQL rejects string literal inserted into a DECIMAL(10,2) numeric column.
-- Expected Error: ERROR 1366 (HY000): Incorrect decimal value: 'eight-hundred' for column 'price' at row 1
-- INSERT INTO products (product_name, sku, price, stock_quantity, status)
-- VALUES ('Protractor', 'PRO-001', 'eight-hundred', 40, 'Active');

-- 1.5: Rejected INSERT Demonstration 2 — Primary Key Violation
-- MySQL rejects duplicate primary key value on AUTO_INCREMENT primary key.
-- Expected Error: ERROR 1062 (23000): Duplicate entry '1' for key 'products.PRIMARY'
-- INSERT INTO products (product_id, product_name, sku, price, stock_quantity, status)
-- VALUES (1, 'Duplicate Item', 'DUP-001', 10.00, 10, 'Active');


-- =============================================================================
-- Task 2 — UPDATE & DELETE Without Collateral Damage (Easy/Medium)
-- Objective: Correct Calculator price from 850.00 to 875.00 and remove Eraser.
-- Discipline: (a) Preview with SELECT, (b) Execute with identical condition on
--             stable identifier, (c) Verify with SELECT.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Part 1: Correct Scientific Calculator price from 850.00 to 875.00
-- -----------------------------------------------------------------------------

-- Step 1(a): PREVIEW target row before modification
SELECT 
    product_id,
    product_name,
    sku,
    price,
    stock_quantity,
    status
FROM products
WHERE product_id = 6;

-- Step 1(b): EXECUTE UPDATE using the verified stable identifier
UPDATE products
SET price = 875.00
WHERE product_id = 6;

-- Step 1(c): VERIFY row reflects updated price
SELECT 
    product_id,
    product_name,
    sku,
    price,
    stock_quantity,
    status
FROM products
WHERE product_id = 6;

-- -----------------------------------------------------------------------------
-- Part 2: Remove Eraser test row (product_id = 5)
-- -----------------------------------------------------------------------------

-- Step 2(a): PREVIEW target row before deletion
SELECT 
    product_id,
    product_name,
    sku,
    price,
    stock_quantity,
    status
FROM products
WHERE product_id = 5;

-- Step 2(b): EXECUTE DELETE using the verified stable identifier
DELETE FROM products
WHERE product_id = 5;

-- Step 2(c): VERIFY row deletion (must return Empty set)
SELECT 
    product_id,
    product_name,
    sku,
    price,
    stock_quantity,
    status
FROM products
WHERE product_id = 5;

-- Step 2(d): Full Table Verification — Exactly 6 records remain intact
SELECT 
    product_id,
    product_name,
    sku,
    price,
    stock_quantity,
    status
FROM products
ORDER BY product_id;

-- Consequence Analysis:
-- If UPDATE products SET price = 875.00 lacked a WHERE clause, EVERY product
-- in the database would have its price overwritten to 875.00, destroying pricing.
-- If DELETE FROM products lacked a WHERE clause, EVERY record in the table
-- would be wiped out permanently, resulting in catastrophic data loss.


-- =============================================================================
-- Task 3 — Self Join & Cross Join (Medium)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Query 3(a): Hierarchical Self Join of employees (e) and managers (m)
-- Preserves top manager (Lea Ramos) whose manager_id is NULL via LEFT JOIN.
-- -----------------------------------------------------------------------------
SELECT 
    e.employee_id,
    e.employee_name,
    e.manager_id,
    m.employee_name AS manager_name
FROM employees AS e
LEFT JOIN employees AS m 
    ON e.manager_id = m.employee_id
ORDER BY e.employee_id;

-- Explanation:
-- Lea Ramos has manager_id = NULL. In SQL three-valued logic, NULL = m.employee_id
-- evaluates to UNKNOWN. An INNER JOIN discards rows evaluating to UNKNOWN, silently
-- dropping Lea. A LEFT JOIN preserves all rows from the left table (e), displaying
-- NULL for manager_name.

-- -----------------------------------------------------------------------------
-- Query 3(b): Deliberate CROSS JOIN of colors and sizes
-- Generates Cartesian product of all variant permutations (3 x 3 = 9 combinations).
-- -----------------------------------------------------------------------------
SELECT 
    c.color_name,
    s.size_name
FROM colors AS c
CROSS JOIN sizes AS s
ORDER BY c.color_name, s.size_name;

-- Query 3(b) Count Verification:
SELECT COUNT(*) AS total_combinations
FROM colors
CROSS JOIN sizes;

-- Business Justification & Missing-ON Warning:
-- Retail catalogs intentionally use CROSS JOIN to generate variant SKU matrices
-- (e.g. 9 color-size configurations of bookstore t-shirts or notebooks).
-- However, an accidental missing ON clause in multi-table transactional queries
-- generates an unconstrained Cartesian explosion (e.g. 10,000 customers x 50,000 orders
-- = 500,000,000 rows), which will exhaust server memory and crash production databases.


-- =============================================================================
-- Task 4 — Constraints & Table Evolution (Medium/Hard)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Step 4(a): Table Evolution — Add contact_number column
-- -----------------------------------------------------------------------------
ALTER TABLE products 
ADD COLUMN contact_number VARCHAR(20);

-- Verify column addition
DESCRIBE products;

-- -----------------------------------------------------------------------------
-- Step 4(b) Rule 1: Enforce product_name NOT NULL
-- -----------------------------------------------------------------------------
ALTER TABLE products 
MODIFY COLUMN product_name VARCHAR(100) NOT NULL;

-- Rule 1: Valid write that passes
INSERT INTO products (product_name, sku, price, stock_quantity, status, contact_number)
VALUES ('Stapler', 'STP-001', 150.00, 40, 'Active', '0917-111-2222');

-- Rule 1: Invalid write rejected by database
-- Expected Error: ERROR 1048 (23000): Column 'product_name' cannot be null
-- INSERT INTO products (product_name, sku, price, stock_quantity, status, contact_number)
-- VALUES (NULL, 'INV-NAME-001', 50.00, 10, 'Active', '0917-000-0000');

-- -----------------------------------------------------------------------------
-- Step 4(b) Rule 2: Enforce sku UNIQUE
-- -----------------------------------------------------------------------------
ALTER TABLE products 
ADD CONSTRAINT uq_products_sku UNIQUE (sku);

-- Rule 2: Valid write that passes
INSERT INTO products (product_name, sku, price, stock_quantity, status, contact_number)
VALUES ('Highlighter Yellow', 'HL-YEL-001', 35.00, 100, 'Active', '0917-333-4444');

-- Rule 2: Invalid write rejected by database
-- Expected Error: ERROR 1062 (23000): Duplicate entry 'NB-001' for key 'products.uq_products_sku'
-- INSERT INTO products (product_name, sku, price, stock_quantity, status, contact_number)
-- VALUES ('Duplicate Notebook', 'NB-001', 45.00, 50, 'Active', '0917-999-8888');

-- -----------------------------------------------------------------------------
-- Step 4(b) Rule 3: Enforce CHECK (price > 0)
-- -----------------------------------------------------------------------------
ALTER TABLE products 
ADD CONSTRAINT chk_products_price CHECK (price > 0);

-- Rule 3: Valid write that passes
INSERT INTO products (product_name, sku, price, stock_quantity, status, contact_number)
VALUES ('Gel Pen Blue', 'GP-BLU-001', 22.50, 80, 'Active', '0917-555-6666');

-- Rule 3: Invalid write rejected by database (Negative Price)
-- Expected Error: ERROR 3819 (HY000): Check constraint 'chk_products_price' is violated.
-- INSERT INTO products (product_name, sku, price, stock_quantity, status, contact_number)
-- VALUES ('Defective Pen', 'DEF-001', -15.00, 5, 'Active', '0917-777-8888');

-- Rule 3: Invalid write rejected by database (Zero Price)
-- Expected Error: ERROR 3819 (HY000): Check constraint 'chk_products_price' is violated.
-- INSERT INTO products (product_name, sku, price, stock_quantity, status, contact_number)
-- VALUES ('Free Giveaway Sticker', 'STK-FREE-001', 0.00, 100, 'Active', '0917-888-9999');

-- -----------------------------------------------------------------------------
-- Final Verification of Table Schema and Data
-- -----------------------------------------------------------------------------
SHOW CREATE TABLE products;

SELECT 
    product_id,
    product_name,
    sku,
    price,
    stock_quantity,
    status,
    contact_number
FROM products
ORDER BY product_id;
