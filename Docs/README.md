# Assignment IV: Advanced Oracle PL/SQL Programming - Hospital Records Management System

**Course:** Database Development with PL/SQL (INSY 8311)  
**Instructor:** Eric Maniraguha  
**Teaching Assistant:** Afanyu Emmanuel  

## Group Members
- **Student 1:** JABO Ghislain (ID: 20252SEN163)
- **Student 2:** HIRWA Langton (ID: 20252SEN087)

**GROUP I Monday Evening from 6pm-10pm.**

## Application Description
The **Hospital Records Management System** is a robust database application designed to manage patient registries, doctor specializations, appointment scheduling, and medical treatment billing. It serves as a practical implementation of advanced Oracle PL/SQL features.

## Repository Structure
- `00_schema/`: Contains table creation scripts and sample data insertion scripts.
- `01_procedures/`: Stored procedures implementing records, implicit cursors, explicit cursors, and bulk processing.
- `02_functions/`: Stored functions calculating aggregate metrics.
- `03_tests/`: Test scripts for successful execution and robust error handling.
- `screenshots/`: Visual verification outputs.
- `docs/`: Implementation and performance documentation.

## How to Run
1. Execute `00_schema/01_create_tables.sql` in your Oracle Database environment (remember to use `SET DEFINE OFF;`).
2. Execute `00_schema/02_insert_sample_data.sql`.
3. Compile all procedure scripts in `01_procedures/`.
4. Compile all function scripts in `02_functions/`.
5. Run test files located in `03_tests/` (e.g., `@03_tests/test_success_cases.sql`).

## AI Assistance Disclosure
An AI assistant was utilized as a collaborative pair-programmer to design the database schema, write PL/SQL blocks, structure exception handling, and prepare documentation. The developer (JABO Ghislain & HIRWA Langton) have reviewed, tested, and fully understands all implemented logic and we are ready to answer any kind of question concerning these.