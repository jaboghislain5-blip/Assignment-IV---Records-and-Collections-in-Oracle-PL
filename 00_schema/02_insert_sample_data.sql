-- =====================================================================
-- Application: Hospital Records Management System
-- Script: 02_insert_sample_data.sql
-- Description: Inserts sample data into patients, doctors, appointments, and treatments.
-- =====================================================================

-- Insert Sample Patients
INSERT INTO patients (first_name, last_name, dob, gender, phone) 
VALUES ('Alice', 'Uwase', TO_DATE('1995-04-12', 'YYYY-MM-DD'), 'Female', '+250781112233');

INSERT INTO patients (first_name, last_name, dob, gender, phone) 
VALUES ('Jean', 'Mugisha', TO_DATE('1988-09-25', 'YYYY-MM-DD'), 'Male', '+250782223344');

INSERT INTO patients (first_name, last_name, dob, gender, phone) 
VALUES ('Diane', 'Kamanzi', TO_DATE('2001-12-05', 'YYYY-MM-DD'), 'Female', '+250783334455');

-- Insert Sample Doctors
INSERT INTO doctors (first_name, last_name, specialization, consultation_fee, status) 
VALUES ('Dr. Patrick', 'Nsengiyumva', 'Cardiology', 25000.00, 'Active');

INSERT INTO doctors (first_name, last_name, specialization, consultation_fee, status) 
VALUES ('Dr. Claire', 'Mukamana', 'Pediatrics', 20000.00, 'Active');

INSERT INTO doctors (first_name, last_name, specialization, consultation_fee, status) 
VALUES ('Dr. Eric', 'Habimana', 'General Medicine', 15000.00, 'Active');

-- Insert Sample Appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) 
VALUES (1, 1, SYSDATE - 2, 'Completed');

INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) 
VALUES (2, 2, SYSDATE - 1, 'Completed');

INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) 
VALUES (3, 3, SYSDATE, 'Scheduled');

-- Insert Sample Treatments
SET DEFINE OFF;
INSERT INTO treatments (appointment_id, treatment_name, cost, treatment_date) 
VALUES (1, 'ECG Scan & Consultation', 45000.00, SYSDATE - 2);

INSERT INTO treatments (appointment_id, treatment_name, cost, treatment_date) 
VALUES (2, 'Pediatric Checkup & Vaccines', 35000.00, SYSDATE - 1);

COMMIT;