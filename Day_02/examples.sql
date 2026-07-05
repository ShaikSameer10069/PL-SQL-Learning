-- =========================================================================
-- 📁 DAY 02: SQL DATA MANIPULATION & ALTER COMMANDS (DETAILED EXAMPLES)
-- =========================================================================

-- ---------------------------------------------------------
-- STEP 1: DATABASE AUR TABLE SETUP KARNA
-- ---------------------------------------------------------
-- Hum yahan IF NOT EXISTS use kar rahe hain taaki error na aaye agar database pehle se ho.
CREATE DATABASE IF NOT EXISTS Day02_MasterDB;
USE Day02_MasterDB;

-- Ek badi table banate hain jisme zyada details hongi
CREATE TABLE CompanyEmployees (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    JobTitle VARCHAR(50),
    Salary DECIMAL(10, 2),
    City VARCHAR(50),
    IsActive BOOLEAN
);

-- Table me 6 logo ka data daalte hain taaki operations samajh aayein
INSERT INTO CompanyEmployees (EmpID, FirstName, JobTitle, Salary, City, IsActive)
VALUES
(101, 'Rahul', 'Software Engineer', 75000.00, 'Pune', TRUE),
(102, 'Priya', 'HR Manager', 65000.00, 'Mumbai', TRUE),
(103, 'Amit', 'Data Analyst', 55000.00, 'Delhi', TRUE),
(104, 'Sneha', 'Software Engineer', 80000.00, 'Bangalore', TRUE),
(105, 'Vikram', 'Intern', 15000.00, 'Pune', TRUE),
(106, 'Ravi', 'Clerk', 25000.00, 'Delhi', FALSE);

-- Data check karne ke liye:
SELECT * FROM CompanyEmployees;


-- ---------------------------------------------------------
-- STEP 2: DATA UPDATE KARNA (CHANGING EXISTING RECORDS)
-- ---------------------------------------------------------

-- Case 1: Kisi ek person ki detail update karna
-- Maan lo Amit (EmpID 103) ki salary badh kar 60,000 ho gayi hai.
UPDATE CompanyEmployees 
SET Salary = 60000.00 
WHERE EmpID = 103;

-- Case 2: Ek sath multiple conditions update karna
-- Vikram (EmpID 105) ab Intern se 'Junior Developer' ban gaya hai aur salary bhi badh gayi hai.
UPDATE CompanyEmployees 
SET JobTitle = 'Junior Developer', Salary = 35000.00 
WHERE EmpID = 105;

-- Case 3: Multiple logo ka data ek sath update karna
-- Saare 'Pune' me rehne wale employees ko bonus de rahe hain (Salary + 5000)
UPDATE CompanyEmployees 
SET Salary = Salary + 5000 
WHERE City = 'Pune';


-- ---------------------------------------------------------
-- STEP 3: DATA DELETE KARNA (REMOVING RECORDS)
-- ---------------------------------------------------------

-- Case 1: Specific single record delete karna
-- Ravi (EmpID 106) ab company me nahi hai (IsActive = FALSE), toh uska data delete karte hain.
DELETE FROM CompanyEmployees 
WHERE EmpID = 106;


-- ---------------------------------------------------------
-- STEP 4: TABLE KA STRUCTURE BADALNA (ALTER TABLE)
-- ---------------------------------------------------------

-- Case 1: Ek naya column ADD karna
-- Table banne ke baad humein yaad aaya ki Phone Number toh daala hi nahi!
ALTER TABLE CompanyEmployees 
ADD PhoneNumber VARCHAR(15);

-- Case 2: Kisi column ko DROP (delete) karna
-- Maan lo 'IsActive' column ki ab zaroorat nahi hai, toh isko hata dete hain.
ALTER TABLE CompanyEmployees 
DROP COLUMN IsActive;

-- Case 3: Column ka Datatype/Size MODIFY karna
-- 'FirstName' ka size VARCHAR(50) se badha kar VARCHAR(100) karna hai.
ALTER TABLE CompanyEmployees 
MODIFY FirstName VARCHAR(100);


-- ---------------------------------------------------------
-- STEP 5: ADVANCED FILTERING (AND, OR, IN)
-- ---------------------------------------------------------

-- 1. AND Operator (Dono baatein sach honi chahiye)
-- Wo Software Engineer dikhao jo 'Bangalore' me rehta hai.
SELECT * FROM CompanyEmployees 
WHERE JobTitle = 'Software Engineer' AND City = 'Bangalore';

-- 2. OR Operator (Koi ek baat sach ho toh chalega)
-- Un logo ko dikhao jo ya toh 'Mumbai' se hain ya 'Delhi' se hain.
SELECT * FROM CompanyEmployees 
WHERE City = 'Mumbai' OR City = 'Delhi';

-- 3. IN Operator (OR ka shortcut method)
-- Agar list badi ho, toh IN use karna best hai (Mumbai, Delhi, aur Pune walo ko dikhao).
SELECT * FROM CompanyEmployees 
WHERE City IN ('Mumbai', 'Delhi', 'Pune');