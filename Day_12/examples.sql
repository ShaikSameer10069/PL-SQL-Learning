-- =========================================================================
-- 📁 DAY 12: DATABASE SECURITY & USER MANAGEMENT (DETAILED EXAMPLES)
-- =========================================================================
-- Note: User create karne aur GRANT/REVOKE chalane ke liye tumhare paas 
-- Root / Admin rights होने चाहिए (e.g., MySQL Workbench me root user se login karein).

-- ---------------------------------------------------------
-- STEP 1: SETUP TEST DATABASE & TABLE
-- ---------------------------------------------------------
CREATE DATABASE IF NOT EXISTS Day12_SecurityDB;
USE Day12_SecurityDB;

-- Ek highly confidential payroll table banate hain
CREATE TABLE EmployeeSalaries (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Designation VARCHAR(50),
    Salary DECIMAL(10, 2),
    BankAccountNum VARCHAR(20)
);

INSERT INTO EmployeeSalaries (EmpID, EmpName, Designation, Salary, BankAccountNum)
VALUES
(1, 'Sameer Khan', 'Lead Architect', 150000.00, 'HDFC0001234'),
(2, 'Aisha Verma', 'HR Manager', 90000.00, 'ICICI0009876'),
(3, 'Rohan Sharma', 'Junior Developer', 45000.00, 'SBI0005432');

SELECT * FROM EmployeeSalaries;


-- =========================================================================
-- 🔥 PART A: CREATING USERS & GRANTING PERMISSIONS (DCL)
-- =========================================================================

-- Step 2: Naye Database Users Create Karna
-- We are creating two users: A Junior Analyst and a Senior HR Admin
CREATE USER IF NOT EXISTS 'junior_analyst'@'localhost' IDENTIFIED BY 'AnalystPass123!';
CREATE USER IF NOT EXISTS 'hr_admin'@'localhost' IDENTIFIED BY 'AdminPass999!';

-- Check karte hain ki abhi inke paas kya power hai (Default me kuch nahi hota):
SHOW GRANTS FOR 'junior_analyst'@'localhost';


-- ---------------------------------------------------------
-- Case 1: Principle of Least Privilege (Read-Only Access)
-- ---------------------------------------------------------
-- Sawaal: Junior Analyst ko sirf table me se data DEKHNE ki permission deni hai.
-- Hum use SELECT permission grant kar rahe hain:

GRANT SELECT ON Day12_SecurityDB.EmployeeSalaries TO 'junior_analyst'@'localhost';

-- Ab agar junior_analyst ye query chalayega, toh SUCCESS hoga:
-- SELECT * FROM EmployeeSalaries;

-- LEKIN agar wo galti se ya jan-bujh kar ye chalayega:
-- DELETE FROM EmployeeSalaries WHERE EmpID = 1;
-- ❌ ERROR 1142: DELETE command denied to user 'junior_analyst'@'localhost'! (Safe! 🛡️)


-- ---------------------------------------------------------
-- Case 2: Multi-Permission Access (Admin Rights)
-- ---------------------------------------------------------
-- Sawaal: HR Admin ko naye employees hire karne (INSERT), unki salary badhane (UPDATE),
-- aur data dekhne (SELECT) ki permission chahiye:

GRANT SELECT, INSERT, UPDATE ON Day12_SecurityDB.EmployeeSalaries TO 'hr_admin'@'localhost';

-- Now HR Admin can easily run UPDATE queries!


-- =========================================================================
-- 🔥 PART B: REVOKING PERMISSIONS & DROPPING USERS
-- =========================================================================

-- Case 1: Permission Wapas Chhinna (`REVOKE`)
-- Scenario: HR Admin ne galti se kisi ki salary galat update kar di. 
-- Boss ne bola ki jab tak investigation ho, inka UPDATE ka power wapas le lo!

REVOKE UPDATE ON Day12_SecurityDB.EmployeeSalaries FROM 'hr_admin'@'localhost';

-- Ab HR Admin sirf SELECT aur INSERT kar sakta hai, UPDATE nahi kar payega! 
SHOW GRANTS FOR 'hr_admin'@'localhost';


-- Case 2: User Account ko Permanently Delete Karna (`DROP USER`)
-- Scenario: Junior Analyst ki internship khatam ho gayi aur wo company chhod kar chala gaya.
-- Uska database account turant delete kar do taaki koi misuse na ho!

DROP USER IF EXISTS 'junior_analyst'@'localhost';


-- =========================================================================
-- 🔥 PART C: PREVENTING SQL INJECTION (HACKING DEFENSE)
-- =========================================================================

-- ---------------------------------------------------------
-- ❌ THE BAD WAY (Vulnerable to SQL Injection)
-- ---------------------------------------------------------
-- Socho tumhare web app (Node.js/Python/PHP) me user se Email aur Password liya gaya.
-- Ek anari developer aisa direct string concatenate karta hai:
-- query = "SELECT * FROM Users WHERE email = '" + user_email + "' AND password = '" + user_pass + "'";

-- HACKER ATTACK: Hacker email input me daalta hai: admin@company.com
-- Aur password input me daalta hai: ' OR '1'='1
-- Final Query jo database me chalti hai wo ban jati hai ye:
SELECT * FROM EmployeeSalaries WHERE EmpName = 'Admin' AND BankAccountNum = '' OR '1'='1';
-- Nateeja: '1'='1' hamesha sach hota hai, aur hacker ko bina password ke saara confidential data dikh jata hai! 😱


-- ---------------------------------------------------------
-- ✅ THE GOOD WAY (Prepared Statements / Parameterized Queries)
-- ---------------------------------------------------------
-- Pro developers kabhi raw input query me nahi jodte. Hum PREPARED STATEMENTS use karte hain.
-- Database placeholders (?) ko pehle compile karta hai, aur input ko sirf ek "Text/String" ki tarah
-- treat karta hai, kabhi "SQL Command" ki tarah execute nahi karta!

-- Step 1: Prepare the statement template with placeholders (?)
PREPARE SafeLoginQuery FROM 'SELECT * FROM EmployeeSalaries WHERE EmpName = ? AND BankAccountNum = ?';

-- Step 2: Pass variables safely into the placeholders
SET @input_name = 'Sameer Khan';
SET @input_account = 'HDFC0001234';

-- Step 3: Execute safely! Even if @input_account contains "' OR '1'='1", database will search for that literal string!
EXECUTE SafeLoginQuery USING @input_name, @input_account;

-- Step 4: Deallocate when done
DEALLOCATE PREPARE SafeLoginQuery;