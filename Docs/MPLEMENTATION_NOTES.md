# Implementation and Performance Notes: Hospital Records Management System

## 1. Architectural Overview
This Oracle PL/SQL application is engineered to manage hospital records, doctors, appointments, and medical treatments. It strictly adheres to advanced PL/SQL programming standards, incorporating modular procedures, functions, explicit and implicit cursors, collections, and bulk DML operations.

## 2. Key Concepts Implemented
- **Records (%ROWTYPE & User-Defined):** Used `%ROWTYPE` in procedures like `register_patient_proc` and `list_doctor_appointments` to seamlessly map table row structures into memory variables without redundant column declarations.
- **Collections (Nested Tables):** Utilized nested tables (`TYPE t_treatment_ids IS TABLE OF ...`) within `apply_bulk_treatment_adjustment` to hold dynamic lists of primary keys and financial data in memory.
- **Cursors:** 
  - *Implicit Cursors:* Leveraged automatically on `INSERT`, `UPDATE`, and `DELETE` operations using attributes like `SQL%FOUND`, `SQL%ROWCOUNT`.
  - *Explicit Cursors:* Handled multi-row result sets explicitly via `OPEN`, `FETCH`, `CLOSE` loops in `list_doctor_appointments`.
- **Bulk Processing & Performance Considerations:**
  - **`BULK COLLECT`**: Fetches multiple rows from the `treatments` table into memory collections in a single context switch, drastically minimizing round-trips between the PL/SQL engine and SQL engine.
  - **`FORALL`**: Executes batch updates on treatment costs rather than running a traditional row-by-row `FOR` loop. This reduces context switching overhead from $O(N)$ to $O(1)$ batch operations.
  - **`SAVE EXCEPTIONS`**: Catches bulk DML processing exceptions (`ORA-24381`) so that a failure in one row doesn't abort the entire batch transaction.
- **Exception Handling:** Integrated predefined exceptions, custom application errors (`RAISE_APPLICATION_ERROR` with error codes `-20001` through `-20004`), and safe cursor cleanup blocks (`IF c_appointments%ISOPEN THEN CLOSE ... END IF;`).