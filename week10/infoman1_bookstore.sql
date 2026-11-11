-- =============================================================================
-- Course: Information Management 1 (INFOMAN1) — Midterm, Week 10
-- Topic: Safe DML & Data Integrity Practical Test (Bookstore Database)
-- Student Name: Geoff Benedict Cariño
-- Student ID: 2511028
-- GitHub Repository: https://github.com/geoxify/infoman1
-- Date Submitted: November 12, 2026
-- =============================================================================

CREATE DATABASE IF NOT EXISTS infoman1_bookstore;
USE infoman1_bookstore;

-- -----------------------------------------------------------------------------
-- Clean existing tables if present to guarantee clean repeatable execution
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS colors;
DROP TABLE IF EXISTS sizes;

-- -----------------------------------------------------------------------------
-- Table 1: products
-- Catalog table storing inventory items, pricing, and stock levels.
-- -----------------------------------------------------------------------------
CREATE TABLE products (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(100),
  sku VARCHAR(30),
  price DECIMAL(10,2),
  stock_quantity INT,
  status VARCHAR(20)
);

-- -----------------------------------------------------------------------------
-- Table 2: sales
-- Transaction table recording sales history linked to products.
-- -----------------------------------------------------------------------------
CREATE TABLE sales (
  sale_id INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT,
  sale_date DATE,
  quantity INT,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- -----------------------------------------------------------------------------
-- Table 3: employees
-- Self-referencing organizational table modeling managerial hierarchy.
-- -----------------------------------------------------------------------------
CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  employee_name VARCHAR(100) NOT NULL,
  manager_id INT
);

-- -----------------------------------------------------------------------------
-- Table 4: colors
-- Master table of product color options for variant generation.
-- -----------------------------------------------------------------------------
CREATE TABLE colors (
  color_name VARCHAR(30) PRIMARY KEY
);

-- -----------------------------------------------------------------------------
-- Table 5: sizes
-- Master table of product size options for variant generation.
-- -----------------------------------------------------------------------------
CREATE TABLE sizes (
  size_name VARCHAR(10) PRIMARY KEY
);

-- -----------------------------------------------------------------------------
-- Seed Data Insertion
-- -----------------------------------------------------------------------------
INSERT INTO products (product_name, sku, price, stock_quantity, status) VALUES
  ('Notebook', 'NB-001', 45.00, 100, 'Active'),
  ('Ballpen', 'BP-001', 15.00, 250, 'Active'),
  ('USB Drive', 'USB-001', 350.00, 30, 'Active'),
  ('Ruler', 'RL-001', 25.00, 80, 'Active'),
  ('Eraser', 'ER-001', 10.00, 200, 'Active');

INSERT INTO sales (product_id, sale_date, quantity) VALUES
  (1, '2026-08-10', 5),
  (2, '2026-08-11', 10);

INSERT INTO employees VALUES
  (1, 'Lea Ramos', NULL),
  (2, 'Carlo Reyes', 1),
  (3, 'Dana Cruz', 1);

INSERT INTO colors VALUES ('Red'), ('Blue'), ('Green');

INSERT INTO sizes VALUES ('S'), ('M'), ('L');
