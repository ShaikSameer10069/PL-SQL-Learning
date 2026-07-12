-- =========================================================================
-- 📁 DAY 09: TRANSACTIONS & CONDITIONAL LOGIC (DETAILED EXAMPLES)
-- =========================================================================
-- Note: Direct tables create kar rahe hain active database me.

-- ---------------------------------------------------------
-- STEP 1: SETUP BANKING TABLE FOR TRANSACTIONS
-- ---------------------------------------------------------
CREATE TABLE Accounts (
    AccID INT PRIMARY KEY,
    HolderName VARCHAR(50),
    Balance DECIMAL(10, 2)
);

INSERT INTO Accounts (AccID, HolderName, Balance)
VALUES
(1, 'Sameer (Sender)', 10000.00),
(2, 'Rahul (Receiver)', 5000.00);

SELECT * FROM Accounts;


-- =========================================================================
-- 🔥 PART A: TRANSACTIONS (`COMMIT`, `ROLLBACK`, `SAVEPOINT`)
-- =========================================================================

-- ---------------------------------------------------------
-- CASE 1: SUCCESSFUL TRANSACTION (`COMMIT`)
-- ---------------------------------------------------------
-- Scenario: Sameer ko Rahul ko ₹2,000 bhejne hain. Sab kuch normal hai.

START TRANSACTION;

-- Step 1: Sameer ke account se paise kaato
UPDATE Accounts SET Balance = Balance - 2000 WHERE AccID = 1;

-- Step 2: Rahul ke account me paise add karo
UPDATE Accounts SET Balance = Balance + 2000 WHERE AccID = 2;

-- Step 3: Dono kaam perfect hue! Ab isko permanently SAVE kar do:
COMMIT;

-- Check karo (Sameer ke 8,000 aur Rahul ke 7,000 ho gaye):
SELECT * FROM Accounts;


-- ---------------------------------------------------------
-- CASE 2: FAILED TRANSACTION (`ROLLBACK`)
-- ---------------------------------------------------------
-- Scenario: Sameer ab ₹3,000 aur bhej raha hai. Uske account se paise kat gaye,
-- lekin tabhi system me error aagaya aur Rahul ke account me paise add nahi hue!

START TRANSACTION;

-- Step 1: Sameer ke account se paise kat gaye (Balance ban gaya 5000)
UPDATE Accounts SET Balance = Balance - 3000 WHERE AccID = 1;

-- ❌ ERROR AAGAYA! Server crash ya network failure ho gaya. Step 2 run hi nahi hua!
-- Ab agar hum yahan chod denge toh Sameer ka ₹3000 nuksan ho jayega!
-- Isliye hum ROLLBACK chalayenge (Undo to start point):
ROLLBACK;

-- Check karo! Magic: Sameer ka balance wapas ₹8,000 ho gaya (Koi nuksan nahi hua):
SELECT * FROM Accounts;


-- ---------------------------------------------------------
-- CASE 3: USING `SAVEPOINT` (Checkpoints in long queries)
-- ---------------------------------------------------------
START TRANSACTION;

-- Point A: ₹500 kaato
UPDATE Accounts SET Balance = Balance - 500 WHERE AccID = 1;
SAVEPOINT Checkpoint_1; -- Yahan tak sab theek hai, checkpoint bana liya

-- Point B: Galti se ₹50000 kaat liye (Jo galat tha!)
UPDATE Accounts SET Balance = Balance - 50000 WHERE AccID = 1;

-- Hame poora transaction cancel nahi karna, sirf Checkpoint_1 ke baad wali galti undo karni hai:
ROLLBACK TO Checkpoint_1;

-- Ab final sahi changes ko save karo:
COMMIT;


-- =========================================================================
-- 🔥 PART B: CONDITIONAL LOGIC (`CASE WHEN`)
-- =========================================================================

-- ---------------------------------------------------------
-- STEP 2: SETUP EMPLOYEE TABLE
-- ---------------------------------------------------------
CREATE TABLE CompanyStaff (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO CompanyStaff (EmpID, Name, Department, Salary)
VALUES
(101, 'Aman', 'IT', 95000.00),
(102, 'Priya', 'HR', 45000.00),
(103, 'Rohan', 'Sales', 60000.00),
(104, 'Sneha', 'IT', 30000.00),
(105, 'Vikram', 'Sales', 85000.00);


-- ---------------------------------------------------------
-- CASE 1: DYNAMIC CATEGORIZATION (Salary Grade Banana)
-- ---------------------------------------------------------
-- Sawaal: Ek list nikalo jisme har employee ke aage uska "Salary Grade" likha ho.
-- Agar 80k+ hai toh 'Senior', 50k+ hai toh 'Mid-Level', warna 'Junior'.

SELECT 
    Name, 
    Department, 
    Salary,
    CASE 
        WHEN Salary >= 80000 THEN 'Senior Level (Tier 1)'
        WHEN Salary >= 50000 THEN 'Mid Level (Tier 2)'
        ELSE 'Junior Level (Tier 3)'
    END AS EmployeeGrade
FROM CompanyStaff;


-- ---------------------------------------------------------
-- CASE 2: CONDITIONAL AGGREGATION (Advance Analysis)
-- ---------------------------------------------------------
-- Sawaal: Hum ek hi query me ginna (count) chahte hain ki kitne log 'IT' se hain 
-- aur kitne log 'Sales' se hain, bina GROUP BY ke alag-alag columns me!

SELECT 
    COUNT(CASE WHEN Department = 'IT' THEN 1 END) AS Total_IT_Staff,
    COUNT(CASE WHEN Department = 'Sales' THEN 1 END) AS Total_Sales_Staff,
    COUNT(CASE WHEN Department = 'HR' THEN 1 END) AS Total_HR_Staff
FROM CompanyStaff;