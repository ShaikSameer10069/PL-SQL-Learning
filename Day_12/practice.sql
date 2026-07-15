-- =========================================================================
-- 🛠️ DAY 12: DATABASE SECURITY & DBA PRACTICE (HANDS-ON EXERCISE)
-- =========================================================================
-- Scenario: Tum ek bade Super-Speciality Hospital ke Chief DBA ho. 
-- Yahan Patients ke confidential medical records store hote hain.
-- Tumhe Doctors, Receptionists aur Billing Staff ke liye strict security setup karni hai!

-- ---------------------------------------------------------
-- TASK 1: CREATE DATABASE & CONFIDENTIAL TABLES
-- ---------------------------------------------------------
CREATE DATABASE IF NOT EXISTS Day12_HospitalDB;
USE Day12_HospitalDB;

CREATE TABLE PatientsMedicalRecords (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(50),
    DiseaseDiagnosis VARCHAR(100),
    DoctorAssigned VARCHAR(50),
    TotalBillAmount DECIMAL(10, 2),
    IsPaymentCleared BOOLEAN
);

INSERT INTO PatientsMedicalRecords VALUES
(101, 'Rajesh Khanna', 'Severe Cardiac Bypass', 'Dr. Sameer', 350000.00, FALSE),
(102, 'Suman Rao', 'Acute Viral Fever', 'Dr. Aisha', 15000.00, TRUE),
(103, 'Vikram Aditya', 'Neurological Surgery', 'Dr. Sameer', 500000.00, FALSE);

SELECT * FROM PatientsMedicalRecords;


-- ---------------------------------------------------------
-- TASK 2: CREATE HOSPITAL STAFF USERS
-- ---------------------------------------------------------
-- Sawaal: Do naye database accounts create karo:
-- 1. 'receptionist_user'@'localhost' with password 'RecPass2026!'
-- 2. 'chief_doctor'@'localhost' with password 'DocMaster100$'

CREATE USER IF NOT EXISTS 'receptionist_user'@'localhost' IDENTIFIED BY 'RecPass2026!';
CREATE USER IF NOT EXISTS 'chief_doctor'@'localhost' IDENTIFIED BY 'DocMaster100$';


-- ---------------------------------------------------------
-- TASK 3: IMPLEMENT PRINCIPLE OF LEAST PRIVILEGE (`GRANT`)
-- ---------------------------------------------------------
-- Sawaal A: Receptionist ko sirf table dekhne (SELECT) aur naye patients admit (INSERT) 
-- karne ki permission do. Wo kisi ka record update ya delete na kar sake!

GRANT SELECT, INSERT ON Day12_HospitalDB.PatientsMedicalRecords TO 'receptionist_user'@'localhost';

-- Sawaal B: Chief Doctor ko table dekhne (SELECT) aur Diagnosis/Doctor update (UPDATE) 
-- karne ki permission do!

GRANT SELECT, UPDATE ON Day12_HospitalDB.PatientsMedicalRecords TO 'chief_doctor'@'localhost';


-- ---------------------------------------------------------
-- TASK 4: HANDLE A SECURITY BREACH (`REVOKE`)
-- ---------------------------------------------------------
-- Sawaal: Hospital management ko pata chala ki Receptionist ke computer se 
-- faltu fake patient records insert ho rahe hain! 
-- Turant 'receptionist_user' se INSERT ki permission wapas chhin lo (`REVOKE`)!

REVOKE INSERT ON Day12_HospitalDB.PatientsMedicalRecords FROM 'receptionist_user'@'localhost';

-- Verify karo ki ab receptionist ke paas sirf SELECT bacha hai:
SHOW GRANTS FOR 'receptionist_user'@'localhost';


-- ---------------------------------------------------------
-- TASK 5: PREPARE A SAFE PATIENT SEARCH QUERY (SQLi Defense)
-- ---------------------------------------------------------
-- Sawaal: Front-end desk software ke liye ek secure PREPARED STATEMENT likho 
-- jiska naam ho 'SearchPatientByDoc'. Ye query Doctor ke naam se patients dhoonde,
-- par SQL Injection se 100% safe ho!

PREPARE SearchPatientByDoc FROM 'SELECT PatientID, PatientName, DiseaseDiagnosis FROM PatientsMedicalRecords WHERE DoctorAssigned = ?';

-- Testing our secure query for 'Dr. Sameer':
SET @doc_name = 'Dr. Sameer';
EXECUTE SearchPatientByDoc USING @doc_name;

-- Clean up memory:
DEALLOCATE PREPARE SearchPatientByDoc;

-- =========================================================================
-- 🎉 DAY 12 COMPLETE! YOU ARE NOW A CERTIFIED DATABASE SECURITY DBA! 🛡️💻
-- =========================================================================