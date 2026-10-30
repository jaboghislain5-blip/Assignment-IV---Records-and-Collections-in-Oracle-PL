SET DEFINE OFF;
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== STARTING SUCCESS TEST CASES ===');
    
    -- 1. Test Patient Registration (Implicit Cursors & %ROWTYPE)
    DBMS_OUTPUT.PUT_LINE(CHR(10) -- Newline for clean output
                         || '--- Test 1: Register New Patient ---');
    register_patient_proc(
        p_first_name => 'Cedric',
        p_last_name  => 'Habimana',
        p_dob        => TO_DATE('1992-07-15', 'YYYY-MM-DD'),
        p_gender     => 'Male',
        p_phone      => '+250784445566'
    );
    
    -- 2. Test Listing Doctor Appointments (Explicit Cursors)
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Test 2: List Appointments for Doctor ID 1 ---');
    list_doctor_appointments(p_doctor_id => 1);
    
    -- 3. Test Bulk Treatment Cost Adjustment (BULK COLLECT & FORALL)
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Test 3: Apply 10% Bulk Cost Increase ---');
    apply_bulk_treatment_adjustment(p_percentage_increase => 10.0);
    
    -- 4. Test Stored Function (Get Patient Total Cost)
    DECLARE
        v_cost NUMBER;
    BEGIN
        v_cost := get_patient_total_cost(p_patient_id => 1);
        DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Test 4: Calculate Total Cost for Patient ID 1 ---');
        DBMS_OUTPUT.PUT_LINE('Total Treatment Cost for Patient 1: RWF ' || TO_CHAR(v_cost, 'FM999,999,990.00'));
    END;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== ALL SUCCESS TESTS COMPLETED SUCCESSFULLY ===');
END;
/