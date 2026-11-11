-- =============================================================================
-- Course: Information Management 1 (INFOMAN1) — Midterm, Week 11
-- Topic: Database Normalization (Tasks 1–4 Execution Script)
-- Student Name: Geoff Benedict Cariño
-- Student ID: 2511028
-- GitHub Repository: https://github.com/geoxify/infoman1
-- Date Submitted: November 12, 2026
-- =============================================================================

USE infoman1_normalization;

-- =============================================================================
-- TASK 1: DIAGNOSE THE ANOMALIES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1(a) Update Anomaly Demonstration
-- Goal: Show how many rows carry department 'D01' and what a rename must touch.
-- -----------------------------------------------------------------------------
-- Count of rows carrying department D01
SELECT dept_id, department_name, COUNT(*) AS row_count
FROM student_enrollment
WHERE dept_id = 'D01'
GROUP BY dept_id, department_name;

-- Displaying the individual rows carrying redundant department facts:
SELECT student_id, student_name, course_id, dept_id, department_name
FROM student_enrollment
WHERE dept_id = 'D01';

-- Structural Cause:
-- The update anomaly is structurally caused by storing department attributes
-- transitively inside student enrollment records, duplicating non-key department
-- facts across multiple student-course rows.

-- -----------------------------------------------------------------------------
-- 1(b) Insert Anomaly Demonstration
-- Goal: Attempt to store new course IT103 ('Intro to Networks', 'D01') with no
--       enrolled student and document what breaks or what placeholder is forced.
-- -----------------------------------------------------------------------------
-- Verifying that course IT103 does not currently exist:
SELECT *
FROM student_enrollment
WHERE course_id = 'IT103';

-- In this denormalized table, a course cannot exist independently of a student.
-- To insert IT103 without an enrolled student, we would be forced to invent artificial
-- dummy/NULL student values, violating entity integrity and polluting student records:
SELECT 
    NULL AS student_id, 
    'PLACEHOLDER' AS student_name, 
    NULL AS enrolled_courses, 
    'IT103' AS course_id, 
    'Intro to Networks' AS course_title, 
    'D01' AS dept_id, 
    'Computing Studies' AS department_name, 
    NULL AS grade;

-- Structural Cause:
-- The insert anomaly is structurally caused by mixing independent entities
-- (courses and students) into an enrollment transaction table, preventing
-- course creation without an active student enrollment.

-- -----------------------------------------------------------------------------
-- 1(c) Delete Anomaly Demonstration
-- Goal: Identify which course facts vanish if Ana's IT102 row is removed.
-- -----------------------------------------------------------------------------
-- Demonstrating that course IT102 only exists in a single enrollment row:
SELECT course_id, course_title, dept_id, department_name, COUNT(*) AS total_enrollments
FROM student_enrollment
WHERE course_id = 'IT102'
GROUP BY course_id, course_title, dept_id, department_name;

-- Displaying the row whose deletion eliminates all course facts for IT102:
SELECT *
FROM student_enrollment
WHERE course_id = 'IT102';

-- Structural Cause:
-- The delete anomaly is structurally caused by coupling the existence of the
-- master course entity to an ephemeral student enrollment record.


-- =============================================================================
-- TASK 2: REACH FIRST NORMAL FORM (1NF)
-- =============================================================================
-- Rebuilding into 1NF:
-- (a) Eliminate multi-valued cell (enrolled_courses) by producing one row per student-course pair.
-- (b) Establish dependable row identity via composite primary key (student_id, course_id).
-- (c) Ensure every cell holds an atomic, indivisible value.
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS student_enrollment_1nf;

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

-- Structure inspection:
DESCRIBE student_enrollment_1nf;

-- Atomic verification query:
SELECT student_id, student_name, course_id, course_title, dept_id, department_name, grade
FROM student_enrollment_1nf
ORDER BY student_id, course_id;


-- =============================================================================
-- TASK 3: REACH SECOND NORMAL FORM (2NF)
-- =============================================================================
-- Candidate / Composite Key: {student_id, course_id}
-- Observed Functional Dependencies:
--   1. student_id -> student_name (Partial Dependency on student_id)
--   2. course_id -> course_title, dept_id, department_name (Partial Dependency on course_id)
--   3. dept_id -> department_name (Transitive Dependency via course_id)
--   4. {student_id, course_id} -> grade (Full Functional Dependency)
--
-- Decomposition:
-- (a) students(student_id, student_name)
-- (b) courses_stage(course_id, course_title, dept_id, department_name)
-- (c) enrollments(student_id, course_id, grade)
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses_stage;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(100) NOT NULL
);

CREATE TABLE courses_stage (
  course_id VARCHAR(10) PRIMARY KEY,
  course_title VARCHAR(100) NOT NULL,
  dept_id VARCHAR(10) NOT NULL,
  department_name VARCHAR(100) NOT NULL
);

CREATE TABLE enrollments (
  student_id INT NOT NULL,
  course_id VARCHAR(10) NOT NULL,
  grade DECIMAL(4,2),
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses_stage(course_id)
);

-- Populate 2NF Tables:
INSERT INTO students VALUES
  (101, 'Ana Cruz'),
  (102, 'Ben Lim');

INSERT INTO courses_stage VALUES
  ('IT101', 'Database Systems', 'D01', 'Computing Studies'),
  ('IT102', 'Web Development', 'D01', 'Computing Studies');

INSERT INTO enrollments VALUES
  (101, 'IT101', 1.50),
  (101, 'IT102', 1.25),
  (102, 'IT101', 1.75);

-- 2NF Reconstructing Join:
SELECT 
    s.student_id,
    s.student_name,
    c.course_id,
    c.course_title,
    c.dept_id,
    c.department_name,
    e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses_stage c ON e.course_id = c.course_id
ORDER BY s.student_id, c.course_id;

-- Justification for grade placement:
-- The attribute grade must remain with the full composite key (student_id, course_id)
-- because a grade is meaningful only for a specific student enrolled in a specific course.


-- =============================================================================
-- TASK 4: REACH THIRD NORMAL FORM (3NF)
-- =============================================================================
-- Transitive Dependency Chain:
--   course_id -> dept_id -> department_name
-- (Non-prime attribute dept_id functionally determines non-prime attribute department_name)
--
-- Decomposition:
-- (a) departments(dept_id, department_name)
-- (b) courses(course_id, course_title, dept_id) [FK referencing departments]
-- (c) enrollments(student_id, course_id, grade) [FK referencing courses and students]
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
  dept_id VARCHAR(10) PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
  course_id VARCHAR(10) PRIMARY KEY,
  course_title VARCHAR(100) NOT NULL,
  dept_id VARCHAR(10) NOT NULL,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE enrollments (
  student_id INT NOT NULL,
  course_id VARCHAR(10) NOT NULL,
  grade DECIMAL(4,2),
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Populate 3NF Tables:
INSERT INTO departments VALUES
  ('D01', 'Computing Studies');

INSERT INTO courses VALUES
  ('IT101', 'Database Systems', 'D01'),
  ('IT102', 'Web Development', 'D01');

INSERT INTO enrollments VALUES
  (101, 'IT101', 1.50),
  (101, 'IT102', 1.25),
  (102, 'IT101', 1.75);

-- Final 3NF Four-Table Reconstructing Join:
SELECT 
    s.student_id,
    s.student_name,
    c.course_id,
    c.course_title,
    d.department_name,
    e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN departments d ON c.dept_id = d.dept_id
ORDER BY s.student_id, c.course_id;
