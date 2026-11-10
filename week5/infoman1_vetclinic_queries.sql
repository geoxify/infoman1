-- =============================================================================
-- Course: Information Management 1 (INFOMAN1)
-- Week 5 Lab: Performance Task Using SQL 2 (SELECT with Conditions)
-- Database Name: infoman1_vetclinic
-- Author: Geoff Benedict Cariño
-- Student ID: 2511028
-- =============================================================================

USE infoman1_vetclinic;

-- -----------------------------------------------------------------------------
-- SETUP / PREREQUISITE DATA: Populate sample records for querying
-- -----------------------------------------------------------------------------

-- 1. Insert Owners
INSERT INTO owner (owner_id, first_name, last_name, phone_number) VALUES
(1, 'Carlos', 'Mendoza', '09171234567'),
(2, 'Maria', 'Santos', '09289876543'),
(3, 'Geoff', 'Cariño', '09185551234'),
(4, 'Ana', 'Reyes', '09451122334')
ON DUPLICATE KEY UPDATE first_name=VALUES(first_name);

-- 2. Insert Pets
INSERT INTO pet (pet_id, pet_name, species, age, owner_id) VALUES
(1, 'Bantay', 'Dog', 4, 1),
(2, 'Luna', 'Cat', 2, 2),
(3, 'Milo', 'Dog', 7, 3),
(4, 'Coco', 'Parrot', 1, 4),
(5, 'Max', 'Dog', 3, 1),
(6, 'Bella', 'Cat', 5, 2)
ON DUPLICATE KEY UPDATE pet_name=VALUES(pet_name);

-- 3. Insert Veterinarians
INSERT INTO veterinarian (vet_id, first_name, last_name, specialization) VALUES
(1, 'Dr. Roberto', 'Cruz', 'General Practice & Surgery'),
(2, 'Dr. Elena', 'Torres', 'Canine & Feline Internal Medicine'),
(3, 'Dr. Samuel', 'Navarro', 'Avian & Exotic Animals')
ON DUPLICATE KEY UPDATE first_name=VALUES(first_name);

-- 4. Insert Appointments
INSERT INTO appointment (appointment_id, appointment_date, reason_for_visit, pet_id, vet_id) VALUES
(1, '2026-10-15 09:00:00', 'Annual Health Checkup & Deworming', 1, 1),
(2, '2026-10-20 14:30:00', 'Limping left hind leg inspection', 3, 2),
(3, '2026-11-05 10:15:00', 'Feather plucking evaluation', 4, 3),
(4, '2026-11-12 11:00:00', 'Post-surgery suture removal follow-up', 5, 1),
(5, '2026-11-18 16:00:00', 'Dental cleaning consultation', 2, 2),
(6, '2026-12-01 13:30:00', 'Routine wellness screening', 6, 2)
ON DUPLICATE KEY UPDATE appointment_date=VALUES(appointment_date);

-- 5. Insert Vaccination Records
INSERT INTO vaccination_record (pet_id, vaccine_name, vaccination_date) VALUES
(1, 'Rabies', '2026-05-10'),
(1, 'DHPP', '2026-06-15'),
(2, 'FVRCP', '2026-04-22'),
(3, 'Rabies', '2026-07-01'),
(5, 'Bordetella', '2026-08-14')
ON DUPLICATE KEY UPDATE vaccine_name=VALUES(vaccine_name);

-- =============================================================================
-- TASK 1: Basic SELECT Statements (Easy)
-- =============================================================================
-- Query 1.1: Return every column and every row from the pet table
SELECT * FROM pet;

-- Query 1.2: Return only the pet_name and species columns from the pet table
SELECT pet_name, species FROM pet;

-- Query 1.2 (Aliased as name and species):
SELECT pet_name AS name, species FROM pet;


-- =============================================================================
-- TASK 2: Filtering with Equality (Easy/Medium)
-- =============================================================================
-- Return the name and species of every pet where species equals a specific value ('Dog')
SELECT pet_name, species 
FROM pet 
WHERE species = 'Dog';

-- Aliased version:
SELECT pet_name AS name, species 
FROM pet 
WHERE species = 'Dog';


-- =============================================================================
-- TASK 3: Filtering with Relational Operators (Medium)
-- =============================================================================
-- Query 3.1: Filtering pet rows using a relational operator on numeric column age (> 3)
SELECT pet_id, pet_name, species, age 
FROM pet 
WHERE age > 3;

-- Query 3.2: Filtering appointment rows by date using a relational operator (>= '2026-11-01')
SELECT appointment_id, appointment_date, reason_for_visit, pet_id, vet_id 
FROM appointment 
WHERE appointment_date >= '2026-11-01 00:00:00';


-- =============================================================================
-- TASK 4: Combine and Debug (Medium/Hard)
-- =============================================================================
-- 4A: Original Working Query
-- Combines a specific column projection list with a WHERE filter on string and numeric conditions
SELECT pet_id, pet_name, species, age 
FROM pet 
WHERE species = 'Dog' AND age >= 4;

-- 4B: Deliberately Broken Query #1 (Missing quotes around string literal)
-- Expected Behavior: MySQL treats unquoted Dog as a column identifier rather than a string literal.
-- Result: ERROR 1054 (42S22): Unknown column 'Dog' in 'where clause'
-- SELECT pet_id, pet_name, species, age FROM pet WHERE species = Dog;

-- 4C: Deliberately Broken Query #2 (Unquoted date causing implicit arithmetic subtraction & type coercion)
-- In MySQL, 2026-11-01 without quotes is evaluated as arithmetic: 2026 - 11 - 1 = 2014.
-- Comparing DATETIME against integer 2014 coerces dates to numbers > 2014, returning ALL unintended rows!
-- SELECT appointment_id, appointment_date, reason_for_visit FROM appointment WHERE appointment_date >= 2026-11-01;
