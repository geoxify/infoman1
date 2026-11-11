-- =============================================================================
-- Course: Information Management 1 (INFOMAN1) — Midterm, Week 11
-- Topic: Database Normalization (1NF, 2NF, 3NF & Anomaly Diagnosis)
-- Student Name: Geoff Benedict Cariño
-- Student ID: 2511028
-- GitHub Repository: https://github.com/geoxify/infoman1
-- Date Submitted: November 12, 2026
-- =============================================================================

CREATE DATABASE IF NOT EXISTS infoman1_normalization;
USE infoman1_normalization;

-- -----------------------------------------------------------------------------
-- Clean existing tables if present to guarantee clean repeatable execution
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS courses_stage;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS student_enrollment_1nf;
DROP TABLE IF EXISTS student_enrollment;

-- =============================================================================
-- PART 0: FLAWED DENORMALIZED SEED TABLE (Original Baseline)
-- =============================================================================
-- The seed intentionally mixes a multi-valued cell (enrolled_courses), repeated
-- student names, and indirect department facts so every anomaly is observable.
-- -----------------------------------------------------------------------------
CREATE TABLE student_enrollment (
  student_id INT,
  student_name VARCHAR(100),
  enrolled_courses VARCHAR(200),
  course_id VARCHAR(10),
  course_title VARCHAR(100),
  dept_id VARCHAR(10),
  department_name VARCHAR(100),
  grade DECIMAL(4,2)
);

INSERT INTO student_enrollment VALUES
  (101, 'Ana Cruz', 'IT101, IT102', 'IT101', 'Database Systems', 'D01', 'Computing Studies', 1.50),
  (102, 'Ben Lim', 'IT101', 'IT101', 'Database Systems', 'D01', 'Computing Studies', 1.75),
  (101, 'Ana Cruz', 'IT101, IT102', 'IT102', 'Web Development', 'D01', 'Computing Studies', 1.25);

-- =============================================================================
-- PART 1: FIRST NORMAL FORM (1NF) TABLE
-- =============================================================================
-- Requirements:
-- 1. All attribute domains are atomic (multi-valued enrolled_courses removed).
-- 2. Dependable row identity via composite PRIMARY KEY (student_id, course_id).
-- -----------------------------------------------------------------------------
CREATE TABLE student_enrollment_1nf (
  student_id INT NOT NULL,
  student_name VARCHAR(100) NOT NULL,
  course_id VARCHAR(10) NOT NULL,
  course_title VARCHAR(100) NOT NULL,
  dept_id VARCHAR(10) NOT NULL,
  department_name VARCHAR(100) NOT NULL,
  grade DECIMAL(4,2),
  PRIMARY KEY (student_id, course_id)
);

INSERT INTO student_enrollment_1nf VALUES
  (101, 'Ana Cruz', 'IT101', 'Database Systems', 'D01', 'Computing Studies', 1.50),
  (101, 'Ana Cruz', 'IT102', 'Web Development', 'D01', 'Computing Studies', 1.25),
  (102, 'Ben Lim', 'IT101', 'Database Systems', 'D01', 'Computing Studies', 1.75);

-- =============================================================================
-- PART 2: SECOND NORMAL FORM (2NF) TABLES
-- =============================================================================
-- Requirements:
-- 1. Must satisfy 1NF.
-- 2. Eliminate partial dependencies (student_id -> student_name and
--    course_id -> course_title, dept_id, department_name).
-- -----------------------------------------------------------------------------
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(100) NOT NULL
);

INSERT INTO students VALUES
  (101, 'Ana Cruz'),
  (102, 'Ben Lim');

CREATE TABLE courses_stage (
  course_id VARCHAR(10) PRIMARY KEY,
  course_title VARCHAR(100) NOT NULL,
  dept_id VARCHAR(10) NOT NULL,
  department_name VARCHAR(100) NOT NULL
);

INSERT INTO courses_stage VALUES
  ('IT101', 'Database Systems', 'D01', 'Computing Studies'),
  ('IT102', 'Web Development', 'D01', 'Computing Studies');

CREATE TABLE enrollments (
  student_id INT NOT NULL,
  course_id VARCHAR(10) NOT NULL,
  grade DECIMAL(4,2),
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses_stage(course_id)
);

INSERT INTO enrollments VALUES
  (101, 'IT101', 1.50),
  (101, 'IT102', 1.25),
  (102, 'IT101', 1.75);

-- =============================================================================
-- PART 3: THIRD NORMAL FORM (3NF) TABLES
-- =============================================================================
-- Requirements:
-- 1. Must satisfy 2NF.
-- 2. Eliminate transitive dependency in course facts:
--    course_id -> dept_id -> department_name.
-- -----------------------------------------------------------------------------
CREATE TABLE departments (
  dept_id VARCHAR(10) PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL
);

INSERT INTO departments VALUES
  ('D01', 'Computing Studies');

CREATE TABLE courses (
  course_id VARCHAR(10) PRIMARY KEY,
  course_title VARCHAR(100) NOT NULL,
  dept_id VARCHAR(10) NOT NULL,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO courses VALUES
  ('IT101', 'Database Systems', 'D01'),
  ('IT102', 'Web Development', 'D01');
