-- =============================================================================
-- Database Seed Script: infoman1_canteen
-- Course: Information Management 1 (INFOMAN1) — Week 9
-- Description: Canteen ordering database schema and initial test dataset
-- =============================================================================

CREATE DATABASE IF NOT EXISTS infoman1_canteen;
USE infoman1_canteen;

-- Drop child tables first to prevent foreign key constraint violations
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS students;

-- Table: students
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(100) NOT NULL,
  program VARCHAR(20) NOT NULL
);

-- Table: orders
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  student_id INT NOT NULL,
  order_date DATE NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Table: menu_items
CREATE TABLE menu_items (
  menu_id INT PRIMARY KEY,
  item_name VARCHAR(100) NOT NULL,
  price DECIMAL(8,2) NOT NULL
);

-- Table: order_items (Bridge/Associative Entity)
CREATE TABLE order_items (
  order_id INT NOT NULL,
  menu_id INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (order_id, menu_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (menu_id) REFERENCES menu_items(menu_id)
);

-- Seed Data: students
-- Notice: Ben Lim (2) and Cara Yu (3) have no orders to observe outer join behavior.
INSERT INTO students (student_id, student_name, program) VALUES
  (1, 'Ana Cruz', 'BSIT'),
  (2, 'Ben Lim', 'BSCS'),
  (3, 'Cara Yu', 'BSIS'),
  (4, 'Dan Reyes', 'BSIT');

-- Seed Data: orders
INSERT INTO orders (order_id, student_id, order_date) VALUES
  (101, 1, '2026-08-10'),
  (102, 1, '2026-08-15'),
  (103, 4, '2026-08-16');

-- Seed Data: menu_items
INSERT INTO menu_items (menu_id, item_name, price) VALUES
  (1, 'Siomai Rice', 65.00),
  (2, 'Burger Steak', 89.00),
  (3, 'Iced Tea', 30.00);

-- Seed Data: order_items
INSERT INTO order_items (order_id, menu_id, quantity) VALUES
  (101, 1, 2),
  (101, 3, 1),
  (102, 2, 1),
  (103, 1, 1);
