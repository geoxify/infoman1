# Week 5 Reflection: DQL Safety and Query Debugging

**Student Name:** Geoff Benedict Cariño  
**Course & Section:** Information Management 1 (INFOMAN1) — Prelim, Week 5  
**Database Name:** infoman1_vetclinic  
**Repository:** [https://github.com/geoxify/infoman1](https://github.com/geoxify/infoman1)  
**Word Count:** 164 words  

---

DQL statements such as `SELECT` are fundamentally read-only operations that query the database engine without modifying disk-persisted data or structural metadata. In sharp contrast, DDL statements (`CREATE`, `ALTER`, `DROP`) permanently reshape schema architecture, while DML commands (`INSERT`, `UPDATE`, `DELETE`) alter table state and risk irreversible record corruption if executed without strict transaction controls. Therefore, `SELECT` can be executed freely during schema exploration and debugging without compromising database integrity or violating ACID guarantees.

In Task 4, I deliberately removed the single quotation marks around the string literal `'Dog'`, executing `WHERE species = Dog`. Instead of filtering for the canine species, MySQL emitted `ERROR 1054 (42S22): Unknown column 'Dog' in 'where clause'`. Because unquoted identifiers represent database objects rather than literal text, the parser attempted to resolve `Dog` as an attribute within the `pet` relation. I diagnosed this breakdown by checking MySQL's descriptive error catalog, recognizing the parser's lexical expectation, and restoring single quotes (`'Dog'`) to designate an explicit string literal, successfully retrieving the filtered subset.
