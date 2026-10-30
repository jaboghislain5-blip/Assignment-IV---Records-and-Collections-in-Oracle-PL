SET DEFINE OFF;

CREATE OR REPLACE FUNCTION get_patient_total_cost (
    p_patient_id IN patients.patient_id%TYPE
) RETURN NUMBER AS
    v_total_cost NUMBER(10, 2) := 0;
    v_exists NUMBER;
BEGIN
    -- Check if patient exists
    SELECT COUNT(*) INTO v_exists
    FROM patients
    WHERE patient_id = p_patient_id;
    
    IF v_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Patient ID ' || p_patient_id || ' not found.');
    END IF;

    -- Calculate total medical treatment costs for the patient
    SELECT NVL(SUM(t.cost), 0) INTO v_total_cost
    FROM treatments t
    JOIN appointments a ON t.appointment_id = a.appointment_id
    WHERE a.patient_id = p_patient_id;
    
    RETURN v_total_cost;
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE BETWEEN -20999 AND -20000 THEN
            RAISE;
        ELSE
            RAISE_APPLICATION_ERROR(-20004, 'Error calculating total patient cost: ' || SQLERRM);
        END IF;
END get_patient_total_cost;
/