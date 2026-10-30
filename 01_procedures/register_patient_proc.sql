SET DEFINE OFF;

CREATE OR REPLACE PROCEDURE register_patient_proc (
    p_first_name IN patients.first_name%TYPE,
    p_last_name  IN patients.last_name%TYPE,
    p_dob        IN patients.dob%TYPE,
    p_gender     IN patients.gender%TYPE,
    p_phone      IN patients.phone%TYPE
) AS
    -- Using %ROWTYPE record declaration
    v_patient_rec patients%ROWTYPE;
BEGIN
    -- Validate gender input
    IF p_gender NOT IN ('Male', 'Female', 'Other') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid gender specified. Must be Male, Female, or Other.');
    END IF;

    -- Insert record
    INSERT INTO patients (first_name, last_name, dob, gender, phone)
    VALUES (p_first_name, p_last_name, p_dob, p_gender, p_phone);

    -- Demonstrate implicit cursor attributes
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Success: Inserted ' || SQL%ROWCOUNT || ' patient record(s).');
    END IF;

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Duplicate patient entry violation.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE || ' - ' || SQLERRM);
        ROLLBACK;
END register_patient_proc;
/