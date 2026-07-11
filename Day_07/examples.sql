-- =========================================================================
-- 📁 DAY 07: CTEs & WINDOW FUNCTIONS (DETAILED EXAMPLES)
-- =========================================================================
-- Note: Direct table create kar rahe hain active database me.

-- ---------------------------------------------------------
-- STEP 1: SETUP ANALYTICS TABLE
-- ---------------------------------------------------------
-- Hum ek sales team ki table bana rahe hain jisme alag-alag departments ke log hain
CREATE TABLE SalesAnalytics (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    TotalSales DECIMAL(10, 2)
);

-- Data insert karte hain (Notice: Kuch logo ki sales ekdum SAME hai, ranking samajhne ke liye)
INSERT INTO SalesAnalytics (EmpID, EmpName, Department, TotalSales)
VALUES
(1, 'Amit', 'Electronics', 80000.00),
(2, 'Priya', 'Electronics', 95000.00),
(3, 'Rohan', 'Electronics', 95000.00), -- Priya aur Rohan ki sales same hai!
(4, 'Sneha', 'Electronics', 60000.00),
(5, 'Vikram', 'Fashion', 70000.00),
(6, 'Anjali', 'Fashion', 85000.00),
(7, 'Karan', 'Fashion', 70000.00);    -- Vikram aur Karan ki sales same hai!

SELECT * FROM SalesAnalytics;


-- =========================================================================
-- 🔥 PART A: CTEs - COMMON TABLE EXPRESSIONS (`WITH` CLAUSE)
-- =========================================================================

-- Sawaal: Mujhe sirf un logo ka data dikhao jinki sales, unke department ki "Average Sales" se zyada hai.
-- Normal Subquery me ye bahut lamba aur confusing ho jata. Hum CTE se isko clean banayenge.

-- ---------------------------------------------------------
-- STEP 2: CREATING AND USING A CTE
-- ---------------------------------------------------------
-- Hum 'DeptAverage' naam ka ek temporary block (CTE) bana rahe hain

WITH DeptAverage AS (
    SELECT Department, AVG(TotalSales) as AvgSales
    FROM SalesAnalytics
    GROUP BY Department
)
-- Ab hum apni main table ko is temporary CTE table ke sath JOIN karenge
SELECT s.EmpName, s.Department, s.TotalSales, d.AvgSales
FROM SalesAnalytics s
INNER JOIN DeptAverage d ON s.Department = d.Department
WHERE s.TotalSales > d.AvgSales;


-- =========================================================================
-- 🔥 PART B: WINDOW FUNCTIONS & RANKING SYSTEM
-- =========================================================================

-- ---------------------------------------------------------
-- STEP 3: UNDERSTANDING OVER() AND PARTITION BY
-- ---------------------------------------------------------
-- Normal GROUP BY lagane se rows kam ho jati hain. 
-- Par hum chahte hain ki har banda apni table me dikhe, aur uske aage uske department ki Total Sales bhi dikhe.

SELECT 
    EmpName, 
    Department, 
    TotalSales,
    SUM(TotalSales) OVER(PARTITION BY Department) AS DeptTotalSales
FROM SalesAnalytics;


-- ---------------------------------------------------------
-- STEP 4: THE BIG INTERVIEW QUESTION - RANK() vs DENSE_RANK() vs ROW_NUMBER()
-- ---------------------------------------------------------
-- Notice karo jab Priya aur Rohan ki sales same (95,000) hai, toh teeno functions kaisa behave karte hain:

SELECT 
    EmpName, 
    Department, 
    TotalSales,
    
    -- 1. ROW_NUMBER(): Ye bas blind numbering karega (1, 2, 3, 4...)
    ROW_NUMBER() OVER(ORDER BY TotalSales DESC) AS RowNum,
    
    -- 2. RANK(): Same marks pe same rank dega, par agla number SKIP kar dega (1, 1, 3...)
    RANK() OVER(ORDER BY TotalSales DESC) AS NormalRank,
    
    -- 3. DENSE_RANK(): Same marks pe same rank dega, aur koi number skip NAHI karega (1, 1, 2...)
    DENSE_RANK() OVER(ORDER BY TotalSales DESC) AS DenseRank
    
FROM SalesAnalytics;


-- ---------------------------------------------------------
-- STEP 5: REAL-WORLD USE CASE (Top 2 Earners per Department)
-- ---------------------------------------------------------
-- Sawaal: Har department se sabse zyada sale karne wale TOP 2 logo ko nikalna hai.
-- Iske liye hum CTE aur DENSE_RANK() ko ek sath combine karenge! Ye ek real Pro-level query hai:

WITH RankedSales AS (
    SELECT 
        EmpName, 
        Department, 
        TotalSales,
        DENSE_RANK() OVER(PARTITION BY Department ORDER BY TotalSales DESC) as RankInDept
    FROM SalesAnalytics
)
SELECT * FROM RankedSales 
WHERE RankInDept <= 2;