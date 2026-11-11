-- =============================================================================
-- Course: INFOMAN1 — Relational Database Management
-- Assessment: Prelim Lab Exam — Task 3: MySQL DDL Implementation
-- Student Name: Geoff Benedict P. Cariño
-- Student ID: 2511028
-- Database Name: toolshare_prelim
-- =============================================================================

-- Step 1: Create and switch to the dedicated database
DROP DATABASE IF EXISTS toolshare_prelim;
CREATE DATABASE toolshare_prelim;
USE toolshare_prelim;

-- Step 2: Create Storage Location Table (1:N Parent)
-- Non-obvious Data Type Justification #1:
-- `location_code` uses VARCHAR(10) instead of CHAR(10) or INT. Storage location identifiers
-- in libraries and community workshops typically combine alphanumeric characters and varying
-- lengths (e.g., 'A3', 'Pegboard B1', 'Shelf 12'). VARCHAR(10) avoids wasting fixed whitespace
-- padding compared to CHAR, while supporting non-numeric labeling schemes that INT cannot store.
CREATE TABLE storage_location (
    location_code VARCHAR(10) NOT NULL,
    description VARCHAR(100) NOT NULL,
    CONSTRAINT pk_storage_location PRIMARY KEY (location_code)
) ENGINE=InnoDB;

-- Step 3: Create Member Table
-- Non-obvious Data Type Justification #2:
-- `phone` uses VARCHAR(20) rather than INT or BIGINT. Mobile telephone numbers in the Philippines
-- and internationally commonly begin with leading zeros (e.g., '09171234567') or international dialing
-- prefixes (e.g., '+639171234567'). Numeric integer types strip leading zeros upon ingestion and reject
-- plus signs, parentheses, or hyphens. VARCHAR(20) preserves exact string formatting without data loss.
CREATE TABLE member (
    member_id INT NOT NULL,
    member_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NULL,
    join_date DATE NOT NULL,
    CONSTRAINT pk_member PRIMARY KEY (member_id)
) ENGINE=InnoDB;

-- Step 4: Create Tool Table
-- Total Participation Enforcement:
-- `location_code` is declared NOT NULL and references storage_location(location_code). This strictly
-- satisfies the specification rule: "Every tool must be assigned to a storage location (total participation)."
CREATE TABLE tool (
    tool_id INT NOT NULL,
    tool_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    purchase_date DATE NOT NULL,
    location_code VARCHAR(10) NOT NULL,
    CONSTRAINT pk_tool PRIMARY KEY (tool_id),
    CONSTRAINT fk_tool_storage_location FOREIGN KEY (location_code)
        REFERENCES storage_location (location_code)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Step 5: Create Certification Table
CREATE TABLE certification (
    cert_id INT NOT NULL,
    cert_name VARCHAR(100) NOT NULL,
    CONSTRAINT pk_certification PRIMARY KEY (cert_id)
) ENGINE=InnoDB;

-- Step 6: Create Tool Requirement Junction Table (Resolves Tool <-> Certification M:N)
-- Enforces composite primary key (tool_id, cert_id) to eliminate duplicate requirement pairings.
CREATE TABLE tool_requirement (
    tool_id INT NOT NULL,
    cert_id INT NOT NULL,
    CONSTRAINT pk_tool_requirement PRIMARY KEY (tool_id, cert_id),
    CONSTRAINT fk_tr_tool FOREIGN KEY (tool_id)
        REFERENCES tool (tool_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_tr_cert FOREIGN KEY (cert_id)
        REFERENCES certification (cert_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Step 7: Create Member Certification Junction Table (Resolves Member <-> Certification M:N)
-- Non-obvious Data Type Justification #3:
-- `completion_date` uses DATE rather than DATETIME or TIMESTAMP. In training and certification
-- records, only the calendar date of successful course completion is legally and administratively
-- relevant. Omitting time of day saves 2–5 bytes per row and simplifies range-based filtering.
CREATE TABLE member_certification (
    member_id INT NOT NULL,
    cert_id INT NOT NULL,
    completion_date DATE NOT NULL,
    CONSTRAINT pk_member_certification PRIMARY KEY (member_id, cert_id),
    CONSTRAINT fk_mc_member FOREIGN KEY (member_id)
        REFERENCES member (member_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_mc_cert FOREIGN KEY (cert_id)
        REFERENCES certification (cert_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Step 8: Create Borrowing Transaction Table (Resolves Member <-> Tool M:N)
-- Non-obvious Data Type Justification #4:
-- `return_date` is explicitly defined as DATE NULL. The spec mandates: "a tool currently on loan
-- has a NULL return date." In MySQL, columns default to nullable unless NOT NULL is specified, but
-- documenting NULL explicitly communicates business intent. When a borrower checks out a tool,
-- the return date is unknown; setting it to NULL signals an active loan rather than relying on a
-- sentinel date (such as '9999-12-31').
CREATE TABLE borrowing (
    borrow_id INT NOT NULL,
    member_id INT NOT NULL,
    tool_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE NULL,
    CONSTRAINT pk_borrowing PRIMARY KEY (borrow_id),
    CONSTRAINT fk_borrowing_member FOREIGN KEY (member_id)
        REFERENCES member (member_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_borrowing_tool FOREIGN KEY (tool_id)
        REFERENCES tool (tool_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Verification: Structural Inspection Commands
SHOW TABLES;

DESCRIBE storage_location;
DESCRIBE member;
DESCRIBE tool;
DESCRIBE certification;
DESCRIBE tool_requirement;
DESCRIBE member_certification;
DESCRIBE borrowing;
