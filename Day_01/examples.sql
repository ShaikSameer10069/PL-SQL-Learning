-- ==========================================
-- Day 01: SQL Basic Examples (Step-by-Step)
-- ==========================================

-- STEP 1: NAYA DATABASE BANANA
-- Database ek bade folder ya box jaisa hai jiske andar hum apni tables rakhenge.
CREATE DATABASE Day01_DB;

-- SQL ko batana padta hai ki kis database ke andar kaam karna hai.
-- Toh hum 'USE' command lagate hain.
USE Day01_DB;


-- STEP 2: TABLE BANANA (Structure set karna)
-- Yahan hum 'Employees' naam ki table bana rahe hain.
-- INT = Numbers ke liye (1, 2, 3...)
-- VARCHAR(50) = Text ya naam ke liye (max 50 words)
-- DECIMAL(10, 2) = Paiso ke liye (Point ke baad 2 digits tak)
-- PRIMARY KEY = Ye ID ko unique rakhega (kisi ka duplicate ID nahi ho sakta)
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);


-- STEP 3: TABLE ME DATA DAALNA (Insert karna)
-- Khali table me rows add karne ke liye INSERT INTO ka use karte hain.
INSERT INTO Employees (EmpID, Name, Department, Salary)
VALUES
(1, 'Amit Sharma', 'IT', 55000.00),
(2, 'Priya Singh', 'HR', 45000.00),
(3, 'Rahul Verma', 'IT', 60000.00),
(4, 'Sneha Patel', 'Finance', 50000.00);


-- STEP 4: DATA DEKHNA YA NIKALNA (Select karna)
-- '*' ka matlab hota hai ALL (saare columns dikhao).
-- Ye query table ka poora data print kar degi.
SELECT * FROM Employees;

-- Agar humein saari details nahi chahiye, sirf Naam aur Department chahiye:
SELECT Name, Department FROM Employees;


-- STEP 5: CONDITION LAGANA (Data Filter karna)
-- WHERE lagane se hum apne hisaab se specific data nikal sakte hain.

-- Example A: Sirf un logo ka data dikhao jo 'IT' department me kaam karte hain.
SELECT * FROM Employees WHERE Department = 'IT';

-- Example B: Sirf un logo ka data dikhao jinki salary 50,000 se zyada hai.
SELECT * FROM Employees WHERE Salary > 50000;