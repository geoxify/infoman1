-- =============================================================================
-- Course: Information Management 1 (INFOMAN1)
-- Week 4 Lab: Performance Task Using SQL 1 (DDL & Table Creation)
-- Database Name: infoman1_vetclinic
-- Author: Geoff Benedict Cariño
-- =============================================================================

-- -----------------------------------------------------------------------------
-- TASK 1: Create and Use Database
-- -----------------------------------------------------------------------------
DROP DATABASE IF EXISTS infoman1_vetclinic;
CREATE DATABASE infoman1_vetclinic;
USE infoman1_vetclinic;

SHOW DATABASES;

-- -----------------------------------------------------------------------------
-- TASK 2: Create Core Tables (owner, pet, veterinarian)
-- -----------------------------------------------------------------------------

-- Note for Task 5: phone_number is intentionally created as INT here as a deliberate
-- design mistake to demonstrate data type mismatch diagnosis and ALTER TABLE correction.
CREATE TABLE owner (
    owner_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number INT,
    PRIMARY KEY (owner_id)
);

CREATE TABLE pet (
    pet_id INT AUTO_INCREMENT,
    pet_name VARCHAR(50) NOT NULL,
    species VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    owner_id INT NOT NULL,
    PRIMARY KEY (pet_id),
    CONSTRAINT fk_pet_owner FOREIGN KEY (owner_id) REFERENCES owner(owner_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE veterinarian (
    vet_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    PRIMARY KEY (vet_id)
);

SHOW TABLES;
