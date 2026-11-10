# INFOMAN1 — Week 4 Lab Answers: Performance Task Using SQL 1 (DDL & Table Creation)

**Student Name:** Geoff Benedict Cariño  
**Course & Section:** Information Management 1 (INFOMAN1) — Prelim, Week 4  
**Database Name:** infoman1_vetclinic  
**Repository:** [https://github.com/geoxify/infoman1](https://github.com/geoxify/infoman1)  

---

## Task 1 — Create the Database

### Objective
Create a dedicated MySQL database named infoman1_vetclinic and verify its creation in the MySQL data catalog using SHOW DATABASES;.

### DDL Implementation
`sql
-- Task 1: Create the database and switch context
DROP DATABASE IF EXISTS infoman1_vetclinic;
CREATE DATABASE infoman1_vetclinic;
USE infoman1_vetclinic;

-- Verification
SHOW DATABASES;
`

### Verification Evidence
![Task 1 Screenshot](screenshots/task1.png)

`	ext
mysql> CREATE DATABASE infoman1_vetclinic;
Query OK, 1 row affected (0.015 sec)

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| infoman1_2511028   |
| infoman1_vetclinic |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
6 rows in set (0.002 sec)

mysql> USE infoman1_vetclinic;
Database changed
`

### Explanation
The Data Definition Language (DDL) statement CREATE DATABASE infoman1_vetclinic; instructs the MySQL storage engine and data dictionary to allocate a distinct schema namespace. Executing SHOW DATABASES; queries the server metadata catalog, confirming that infoman1_vetclinic exists alongside the default system databases (information_schema, mysql, performance_schema, sys) and the Week 1 database (infoman1_2511028). Finally, USE infoman1_vetclinic; sets the active database session context for subsequent table creation.
