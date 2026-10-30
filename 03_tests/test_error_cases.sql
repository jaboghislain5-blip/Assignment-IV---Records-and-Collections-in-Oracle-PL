SET DEFINE OFF;
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== STARTING ERROR HANDLING TEST CASES ===');
    
    -- 1. Test Invalid Gender Input (User-defined custom exception / RAISE_APPLICATION_ERROR)
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Test Error 1: Invalid Gender Validation ---');
    BEGIN
        register_patient_proc(
            p_first_name => 'Test',
            p_last_name  => 'User',
            p_dob        => TO_DATE('2000-01-01', 'YYYY-MM-DD'),
            p_gender     => 'Unknown', -- Invalid
            p_phone      => '+250780000000'
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
    END;
    
    -- 2. Test Non-Existent Doctor ID (NO_DATA_FOUND / Custom Exception)
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Test Error 2: Non-Existent Doctor ID ---');
    BEGIN
        list_doctor_appointments(p_doctor_id => 9999);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
    END;
    
    -- 3. Test Non-Existent Patient ID in Function
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Test Error 3: Non-Existent Patient ID in Function ---');
    DECLARE
        v_dummy NUMBER;
    BEGIN
        v_dummy := get_patient_total_cost(p_patient_id => 9999);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
    END;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== ALL ERROR TESTS COMPLETED SUCCESSFULLY ===');
END;
/