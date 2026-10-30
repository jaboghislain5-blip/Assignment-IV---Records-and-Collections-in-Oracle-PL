SET DEFINE OFF;
CREATE OR REPLACE PROCEDURE list_doctor_appointments (
    p_doctor_id IN doctors.doctor_id%TYPE
) AS
    -- Explicit Cursor definition joining appointments and patients
    CURSOR c_appointments IS
        SELECT a.appointment_id, p.first_name || ' ' || p.last_name AS patient_name, a.appointment_date, a.status
        FROM appointments a
        JOIN patients p ON a.patient_id = p.patient_id
        WHERE a.doctor_id = p_doctor_id;
        
    v_app_rec c_appointments%ROWTYPE;
    v_doc_name VARCHAR2(100);
BEGIN
    -- Verify doctor existence (Implicit cursor check)
    SELECT first_name || ' ' || last_name INTO v_doc_name
    FROM doctors WHERE doctor_id = p_doctor_id;
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Appointments for Dr. ' || v_doc_name);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    
    -- Explicit cursor loop execution
    OPEN c_appointments;
    LOOP
        FETCH c_appointments INTO v_app_rec;
        EXIT WHEN c_appointments%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('App ID: ' || v_app_rec.appointment_id || 
                             ' | Patient: ' || v_app_rec.patient_name || 
                             ' | Date: ' || TO_CHAR(v_app_rec.appointment_date, 'YYYY-MM-DD') || 
                             ' | Status: ' || v_app_rec.status);
    END LOOP;
    CLOSE c_appointments;
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Doctor with ID ' || p_doctor_id || ' does not exist.');
    WHEN OTHERS THEN
        IF c_appointments%ISOPEN THEN
            CLOSE c_appointments;
        END IF;
        RAISE_APPLICATION_ERROR(-20099, 'Unexpected error: ' || SQLERRM);
END list_doctor_appointments;
/