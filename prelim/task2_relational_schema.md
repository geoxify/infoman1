# ToolShare Relational Database Schema (Task 2)

**Course:** INFOMAN1 — Relational Database Management  
**Student Name:** Geoff Benedict P. Cariño  
**Student ID:** 2511028  
**Assessment:** Prelim Lab Exam — Task 2 Relational Schema  

---

## 1. Standard Relational Schema Notation

In accordance with relational database modeling standards:
- Primary key attributes are <u>underlined</u>.
- Composite primary keys are represented by underlining all constituent attributes.
- Foreign keys are marked with `[FK]`, indicating a referential constraint pointing to the primary key of a parent relation.
- Relationship attributes extracted from the conceptual ERD are embedded directly into the appropriate junction relations.

```text
storage_location(<u>location_code</u>, description)

member(<u>member_id</u>, member_name, phone, join_date)

tool(<u>tool_id</u>, tool_name, category, purchase_date, location_code [FK])

certification(<u>cert_id</u>, cert_name)

tool_requirement(<u>tool_id</u> [FK], <u>cert_id</u> [FK])

member_certification(<u>member_id</u> [FK], <u>cert_id</u> [FK], completion_date)

borrowing(<u>borrow_id</u>, member_id [FK], tool_id [FK], borrow_date, return_date)
```

*(Note on Primary Key Strategy for `borrowing`: The natural candidate key is `(member_id, tool_id, borrow_date)`, which uniquely distinguishes each loan instance assuming a member cannot borrow the identical physical tool twice on the exact same date. In production relational engineering and to align with the provided lab sample data script, an integer surrogate primary key `borrow_id` is adopted, with `member_id` and `tool_id` enforced as foreign keys).*

---

## 2. Table-by-Table Schema Specification

### 1. `storage_location`
- **Purpose:** Represents physical inventory storage units (e.g., shelves, pegboards, cabinets).
- **Primary Key:** `location_code` (e.g., `'A3'`, `'B1'`)
- **Attributes:**
  - `location_code`: Alphanumeric code uniquely identifying the location.
  - `description`: Textual description of the storage unit.
- **Participation:** 1:N with `tool`. A storage location may hold zero or more tools (optional), but every tool must be assigned to exactly one storage location (mandatory / total participation).

### 2. `member`
- **Purpose:** Represents community residents registered to borrow tools from ToolShare.
- **Primary Key:** `member_id`
- **Attributes:**
  - `member_id`: Unique integer assigned to each member.
  - `member_name`: Full legal name of the resident.
  - `phone`: Contact telephone / mobile number.
  - `join_date`: Calendar date when membership was established.

### 3. `tool`
- **Purpose:** Represents physical tools available for loan in the neighborhood library.
- **Primary Key:** `tool_id`
- **Foreign Keys:**
  - `location_code [FK]` references `storage_location(location_code)` — enforces total participation.
- **Attributes:**
  - `tool_id`: Unique numeric tool identifier.
  - `tool_name`: Descriptive equipment title (e.g., "Cordless Drill").
  - `category`: Functional category classification (e.g., "Power Tools", "Garden", "Hand Tools").
  - `purchase_date`: Date the tool was acquired.
  - `location_code`: Storage location where the tool is kept when not on loan.

### 4. `certification`
- **Purpose:** Catalog of safety and equipment training certifications administered or recognized by ToolShare.
- **Primary Key:** `cert_id`
- **Attributes:**
  - `cert_id`: Unique numeric certification identifier.
  - `cert_name`: Name of certification course (e.g., "Chainsaw Safety", "Welding Basics").

### 5. `tool_requirement`
- **Purpose:** Junction table resolving the M:N relationship between `tool` and `certification` ("A tool may require multiple certifications; a certification may apply to multiple tools").
- **Primary Key:** Composite `(tool_id, cert_id)`
- **Foreign Keys:**
  - `tool_id [FK]` references `tool(tool_id)` ON DELETE RESTRICT ON UPDATE CASCADE
  - `cert_id [FK]` references `certification(cert_id)` ON DELETE RESTRICT ON UPDATE CASCADE
- **Semantics:** Each record signifies that safety certification `cert_id` is mandatory before tool `tool_id` may be issued to a borrower.

### 6. `member_certification`
- **Purpose:** Junction table resolving the M:N relationship between `member` and `certification` ("Members complete certifications over time").
- **Primary Key:** Composite `(member_id, cert_id)`
- **Foreign Keys:**
  - `member_id [FK]` references `member(member_id)` ON DELETE RESTRICT ON UPDATE CASCADE
  - `cert_id [FK]` references `certification(cert_id)` ON DELETE RESTRICT ON UPDATE CASCADE
- **Relationship Attributes:**
  - `completion_date`: Date the member completed the safety training.

### 7. `borrowing`
- **Purpose:** Event/transaction table resolving the M:N relationship between `member` and `tool` ("A member may borrow many tools over time; a tool may be borrowed by many members across its lifetime").
- **Primary Key:** `borrow_id` (Surrogate Primary Key)
- **Foreign Keys:**
  - `member_id [FK]` references `member(member_id)` ON DELETE RESTRICT ON UPDATE CASCADE
  - `tool_id [FK]` references `tool(tool_id)` ON DELETE RESTRICT ON UPDATE CASCADE
- **Relationship Attributes:**
  - `borrow_date`: Calendar date on which the tool was checked out.
  - `return_date`: Calendar date on which the tool was returned to inventory. Explicitly nullable (`NULL`) when the tool is currently checked out on loan.

---

## 3. Relational Mapping & Integrity Rules Traceability Matrix

| Business Rule from Spec | Relational Design Resolution | Referential Integrity Enforcement |
|---|---|---|
| "Each tool belongs to exactly one storage location... Every tool must be assigned to a storage location (total participation)." | Column `location_code` added to `tool` table. | `location_code VARCHAR(10) NOT NULL`, FK to `storage_location(location_code)` |
| "A storage location may hold zero or more tools." | Optional on storage location side; 1:N cardinality. | Parent table `storage_location` has no foreign key to `tool`. |
| "A member may borrow many tools over time, and a tool may be borrowed by many different members..." | Resolved M:N into associative entity `borrowing`. | Foreign keys `member_id` and `tool_id` in `borrowing`. |
| "Each borrowing event records the borrow date and return date; a tool currently on loan has a NULL return date." | Attributes `borrow_date` and `return_date` placed in `borrowing`. | `return_date DATE NULL` allowing active loan representation. |
| "Each certification may apply to multiple tools while each tool may require multiple certifications." | Resolved M:N into junction table `tool_requirement`. | Composite PK `(tool_id, cert_id)` referencing both parent tables. |
| "When a member completes a certification, ToolShare records the completion date." | Resolved M:N into junction table `member_certification` with `completion_date`. | Composite PK `(member_id, cert_id)`, `completion_date DATE NOT NULL`. |
