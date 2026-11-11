# Task 6: Video Walkthrough Teleprompter Script

**Student Name:** Geoff Benedict P. Cariño  
**Student ID:** 2511028  
**Course:** INFOMAN1 — Relational Database Management  
**Assessment:** Prelim Lab Exam Walkthrough  
**Target Duration:** ~10–12 Minutes (Strictly under the 15-minute exam threshold)  
**Tone:** Confident, structured, academic, professional  

---

## Recording Setup & Quick Checklist Before You Press Record

1. **Screen Layout:**
   - Window 1 (Left / Fullscreen): Image viewer or web browser displaying `task1_conceptual_erd.png` and `task2_logical_erd.png`.
   - Window 2: VS Code / Text editor showing `task2_relational_schema.md` and `task3_ddl.sql`.
   - Window 3: Terminal or MySQL Workbench connected to your local MySQL instance (`USE toolshare_prelim;`).
2. **Pre-requisite Execution:**
   - Make sure you ran `task3_ddl.sql` and `toolshare_sample_data.sql` so the tables and sample rows are already populated.
3. **Pacing:** Read at a steady, natural speaking pace (approx. 130–140 words per minute).

---

## Verbatim Teleprompter Script

---

### [00:00 – 01:15] Section 1: Introduction & Scenario Overview

**[ON SCREEN: Display title screen or open `infoman1/prelim/` folder in VS Code]**

> "Good day, Ma'am/Sir. My name is **Geoff Benedict Cariño**, Student ID **2511028**, and this is my video walkthrough for the **INFOMAN1 Prelim Lab Exam** covering Weeks 1 through 5.
>
> In this assessment, we are tasked with engineering a complete relational database management system for **ToolShare**, a community tool-lending library.
>
> The specification requires ToolShare to manage four core aspects of its operations:
> 1. Tracking neighborhood residents registered as **Members**;
> 2. Tracking the library's physical inventory of **Tools**;
> 3. Enforcing mandatory **Safety Certifications** required before members can borrow specialized equipment; and
> 4. Managing the physical workshop **Storage Locations** where tools are housed.
>
> Over the next ten to twelve minutes, I will walk you through the end-to-end implementation: starting with the conceptual ERD, translating it into the logical ERD and relational schema, implementing the MySQL DDL, executing our Task 4 sample data queries, and finally diagnosing the cross-week query mismatch in Task 5."

---

### [01:15 – 03:30] Section 2: Task 1 — Conceptual ERD Walkthrough (Weeks 1–2)

**[ON SCREEN: Switch to `task1_conceptual_erd.png` or open `task1_conceptual_erd.drawio` in draw.io]**

> "Let us begin with **Task 1: The Conceptual ERD**.
>
> Following the database design methodology from Weeks 1 and 2, our objective here is to capture the business domain faithfully without prematurely jumping to physical database structures.
>
> First, let's examine the **four core entities**:
> - **Member:** Identified by primary key `member_id`, with attributes `member_name`, `phone`, and `join_date`.
> - **Tool:** Identified by primary key `tool_id`, with attributes `tool_name`, `category`, and `purchase_date`.
> - **Storage Location:** Identified by `location_code`, with a textual `description`.
> - **Certification:** Identified by `cert_id`, with `cert_name`.
>
> Each of these represents an autonomous, strong real-world entity with its own independent primary key.
>
> Now, looking at the **relationships and cardinality** using Crow's Foot notation:
>
> 1. **`Member` to `Tool` via `borrows`:**  
>    The spec states: *'A member may borrow many tools over time, and a tool may be borrowed by many different members across its lifetime.'*  
>    This is a classic **Many-to-Many ($M:N$)** relationship. Both sides participate optionally ($0..N$) because a new member has borrowed zero tools, and an unborrowed tool has zero loans. Crucially, the transaction attributes—`borrow_date` and nullable `return_date`—belong to this relationship diamond.
>
> 2. **`Tool` to `Certification` via `requires`:**  
>    The spec states: *'Each certification may apply to multiple tools while each tool may require multiple certifications.'*  
>    This is also an **$M:N$** relationship with $0..N$ cardinality on both ends, because basic tools (like hammers) require zero certifications, and new certifications might not yet be assigned to tools.
>
> 3. **`Member` to `Certification` via `completes`:**  
>    Members can complete zero, one, or several certifications over time, making this an **$M:N$** relationship. We attach the relationship attribute `completion_date` here.
>
> 4. **`Storage Location` to `Tool` via `houses`:**  
>    The spec explicitly states: *'Each tool belongs to exactly one storage location... Every tool must be assigned to a storage location (total participation). A storage location may hold zero or more tools.'*  
>    Therefore, this is a **1-to-Many ($1:N$)** relationship. Notice the cardinality markers: on the Tool side, we have mandatory total participation—denoted by $1..1$ (double bars)—meaning every tool must belong to a location. On the Storage Location side, it is optional zero-to-many ($0..N$), since a newly created shelf or bin might hold zero tools initially.
>
> In strict accordance with the Task 1 acceptance criteria, none of the $M:N$ relationships have been prematurely resolved into junction tables at this conceptual stage."

---

### [03:30 – 05:15] Section 3: Task 2 — Logical ERD & Relational Schema (Week 3)

**[ON SCREEN: Switch to `task2_logical_erd.png` and scroll through `task2_relational_schema.md`]**

> "Moving on to **Task 2: Logical ERD and Relational Schema Translation**, which applies our Week 3 concepts.
>
> In relational theory, relational tables cannot directly store Many-to-Many relationships or multivalued relationship attributes. Therefore, we resolve each $M:N$ relationship into an associative junction entity:
>
> 1. The $M:N$ `borrows` relationship becomes the table **`borrowing`**. It inherits `member_id` as a foreign key referencing `member`, and `tool_id` referencing `tool`. We include the relationship attributes `borrow_date` and `return_date`. While the natural candidate key is `(member_id, tool_id, borrow_date)`, we assign an integer surrogate primary key `borrow_id` for efficient indexing and consistency with the instructor's sample dataset.
> 2. The $M:N$ `requires` relationship becomes the junction table **`tool_requirement`**, with a **composite primary key** of `(tool_id, cert_id)`. Both attributes also serve as foreign keys referencing their respective parent entities.
> 3. The $M:N$ `completes` relationship becomes **`member_certification`**, with a composite primary key of `(member_id, cert_id)` plus the attribute `completion_date`.
> 4. For the 1:N relationship between `storage_location` and `tool`, we migrate the primary key `location_code` into `tool` as a foreign key. To enforce total participation, `tool.location_code` is constrained as `NOT NULL`.
>
> Here is our complete relational schema in standard notation:
> ```text
> storage_location(location_code, description)
> member(member_id, member_name, phone, join_date)
> tool(tool_id, tool_name, category, purchase_date, location_code [FK])
> certification(cert_id, cert_name)
> tool_requirement(tool_id [FK], cert_id [FK])
> member_certification(member_id [FK], cert_id [FK], completion_date)
> borrowing(borrow_id, member_id [FK], tool_id [FK], borrow_date, return_date)
> ```
> In this notation, all primary keys are underlined, and all foreign keys are clearly designated with `[FK]`."

---

### [05:15 – 07:15] Section 4: Task 3 — MySQL DDL Implementation (Week 4)

**[ON SCREEN: Switch to terminal or MySQL Workbench. Type: `USE toolshare_prelim; SHOW TABLES;`]**

> "Now let us transition to **Task 3: MySQL DDL Implementation**.
>
> In MySQL, I executed our DDL script `task3_ddl.sql`, which created the database `toolshare_prelim`.
>
> Running `SHOW TABLES;`, we confirm that all seven tables were created successfully:
> - `borrowing`
> - `certification`
> - `member`
> - `member_certification`
> - `storage_location`
> - `tool`
> - `tool_requirement`
>
> Let's look at `DESCRIBE` on our tables and explain my data type choices:
>
> **[Type: `DESCRIBE storage_location;` and `DESCRIBE member;`]**
>
> Notice two key non-obvious data type justifications:
> 1. **`phone` in `member` is `VARCHAR(20)`:**  
>    As we learned in Week 4, storing phone numbers as `INT` is a catastrophic design mistake. Philippine mobile numbers begin with a leading zero (e.g., `09171234567`). Numeric integer types strip leading zeros upon ingestion and exceed 32-bit integer limits ($2.14$ billion). `VARCHAR(20)` safely preserves leading zeros, spaces, and international dialing prefixes like `+63`.
> 2. **`location_code` in `storage_location` and `tool` is `VARCHAR(10)`:**  
>    Instead of an integer or fixed `CHAR`, workshop storage units use alphanumeric codes like `'A3'`, `'B1'`, or `'Cabinet C2'`. `VARCHAR(10)` avoids wasting fixed whitespace padding while supporting letters and hyphens.
>
> **[Type: `DESCRIBE tool;` and `DESCRIBE borrowing;`]**
>
> Two more critical design decisions:
> 3. **`location_code` in `tool` has `Null = NO` and `Key = MUL`:**  
>    This enforces foreign key referential integrity referencing `storage_location(location_code)` while enforcing mandatory total participation.
> 4. **`return_date` in `borrowing` allows `NULL`:**  
>    The spec explicitly states that currently loaned tools have a `NULL` return date. By declaring `return_date DATE NULL`, we cleanly represent ongoing loans without relying on hacky sentinel dates like `'9999-12-31'`.
>
> **[Type: `DESCRIBE tool_requirement;` and `DESCRIBE member_certification;`]**
>
> Finally, inspecting our junction tables confirms that both columns display `PRI` under the Key column, verifying that MySQL has correctly cataloged and enforced our composite primary keys."

---

### [07:15 – 09:15] Section 5: Task 4 — Sample Data Queries (Week 5)

**[ON SCREEN: Terminal showing execution of each Task 4 query]**

> "Next is **Task 4: Sample Data Queries**, where we populated `toolshare_sample_data.sql` and wrote five `SELECT` queries with `WHERE` clauses to answer specific operational questions.
>
> Let's run Query 1:
>
> **[Execute Query 1:]**
> ```sql
> SELECT tool_name, category
> FROM tool
> WHERE category = 'Power Tools';
> ```
> *'This projects the name and category for all equipment classified as Power Tools. The equality filter matches three records: the Cordless Drill, Circular Saw, and Angle Grinder.'*
>
> Now Query 2:
>
> **[Execute Query 2:]**
> ```sql
> SELECT member_id, member_name, phone, join_date
> FROM member
> WHERE join_date > '2025-01-01';
> ```
> *'Here we use the relational greater-than operator against the date literal 2025-01-01. It accurately returns four members who registered during 2025: Jose Rizal, Ana Reyes, Liza Gomez, and Kevin Lim.'*
>
> Query 3:
>
> **[Execute Query 3:]**
> ```sql
> SELECT borrow_id, member_id, tool_id, borrow_date, return_date
> FROM borrowing
> WHERE return_date IS NULL;
> ```
> *'This query identifies active loans. Notice we use `return_date IS NULL` rather than `= NULL`. Under SQL's Three-Valued Logic, any equality comparison with NULL yields UNKNOWN. `IS NULL` correctly returns two active loans: borrow ID 2 and borrow ID 3.'*
>
> Query 4:
>
> **[Execute Query 4:]**
> ```sql
> SELECT borrow_id, member_id, tool_id, borrow_date, return_date
> FROM borrowing
> WHERE member_id = 1;
> ```
> *'Filtering on foreign key `member_id = 1` retrieves all borrowing history for Maria Santos, showing one returned loan and one active loan.'*
>
> Query 5:
>
> **[Execute Query 5:]**
> ```sql
> SELECT tool_id, tool_name, category, purchase_date, location_code
> FROM tool
> WHERE purchase_date < '2024-01-01';
> ```
> *'Using the strictly less-than comparison operator on `purchase_date`, this identifies tools acquired before 2024: the Cordless Drill, Circular Saw, and Garden Shovel.'*
>
> All five queries executed cleanly and returned non-empty, meaningful results."

---

### [09:15 – 11:15] Section 6: Task 5 — Debugging the Cross-Week Mismatch (Weeks 3–5)

**[ON SCREEN: Paste the broken query into the terminal and press Enter]**

> "Now let us examine **Task 5: Debugging a Cross-Week Mismatch**.
>
> Our instructor provided this query, intended to list borrowing records for 'Maria Santos':
> ```sql
> SELECT borrow_date, return_date
> FROM borrowing
> WHERE member_name = 'Maria Santos';
> ```
>
> When I execute this in MySQL, watch what happens:
> **`ERROR 1054 (42S22): Unknown column 'member_name' in 'where clause'`**
>
> Let's analyze why this error occurs, spanning our concepts from Weeks 3, 4, and 5:
>
> 1. **Week 3 Schema Design & Normalization:**  
>    In relational theory, attributes must reside in the entity to which they belong. A resident's name describes a `member`, not a loan transaction. If we stored `member_name` inside `borrowing`, every time Maria Santos borrowed a tool, we would duplicate her name, violating Second and Third Normal Form and creating update anomalies. Therefore, our Task 2 relational design stores only the foreign key `member_id` in `borrowing`.
> 2. **Week 4 DDL Implementation:**  
>    When we created `borrowing` in Task 3, its columns were `borrow_id`, `member_id`, `tool_id`, `borrow_date`, and `return_date`. There is literally no column named `member_name` in the table catalog.
> 3. **Week 5 Query Resolution Scope:**  
>    In basic DQL, a `WHERE` clause can only evaluate predicates against columns present in the table listed in the `FROM` clause.
>
> Because we have not yet covered SQL `JOIN` operations in Week 5, we correct this using a **two-step single-table lookup**:
>
> **Step 1:** Look up Maria Santos's `member_id` from the `member` table:
> **[Execute Step 1:]**
> ```sql
> SELECT member_id
> FROM member
> WHERE member_name = 'Maria Santos';
> ```
> This returns `member_id = 1`.
>
> **Step 2:** Query the `borrowing` table using that resolved foreign key:
> **[Execute Step 2:]**
> ```sql
> SELECT borrow_date, return_date
> FROM borrowing
> WHERE member_id = 1;
> ```
>
> And immediately, MySQL returns both of Maria Santos's borrowing records—one returned on September 10, and one active loan from September 12.
>
> This exercise perfectly illustrates **foreign key dereferencing** and the separation of human-readable identities from relational keys in normalized database management."

---

### [11:15 – 12:00] Section 7: Conclusion & Git Repository Submission

**[ON SCREEN: Switch to VS Code terminal or GitHub browser view showing `infoman1/prelim/`]**

> "To conclude, all exam deliverables have been committed to my GitHub repository under `infoman1/prelim/`:
> - `task1_conceptual_erd.drawio` and `.png`
> - `task2_logical_erd.drawio` and `.png`
> - `task2_relational_schema.md`
> - `task3_ddl.sql` and `task3_describe_output.txt`
> - `task4_queries.sql`
> - The comprehensive answer document, `prelim_lab_answers.md`
> - And this video walkthrough link uploaded as unlisted to YouTube.
>
> Thank you very much for your time and guidance throughout Weeks 1 to 5!"

---

## Post-Recording Action:
Once you finish recording and upload your video to YouTube as **Unlisted**:
1. Copy your YouTube video URL (e.g., `https://youtu.be/...`).
2. Open `infoman1/prelim/prelim_lab_answers.md`.
3. Replace `[INSERT_UNLISTED_YOUTUBE_LINK_HERE]` with your actual YouTube URL.
4. Run `git commit -am "Task 6: Add unlisted YouTube walkthrough video URL"` and push to your GitHub repo!
