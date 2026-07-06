-- =========================================================================
-- 📁 DAY 03: SQL DATA ANALYSIS & AGGREGATION (DETAILED EXAMPLES)
-- =========================================================================

-- Note: Hum assume kar rahe hain ki database pehle se selected hai (USE your_db_name; agar zaroorat ho toh run kar lena)

-- ---------------------------------------------------------
-- STEP 1: TABLE SETUP FOR ANALYSIS
-- ---------------------------------------------------------
-- Data analysis samajhne ke liye ek 'StoreSales' ki badi table banate hain
CREATE TABLE StoreSales (
    SaleID INT PRIMARY KEY,
    SalesmanName VARCHAR(50),
    Region VARCHAR(50),
    Product VARCHAR(50),
    Amount DECIMAL(10, 2)
);

-- Bulk Data daalte hain taaki sorting aur math operations samajh aayein
INSERT INTO StoreSales (SaleID, SalesmanName, Region, Product, Amount)
VALUES
(1, 'Ramesh', 'North', 'Laptop', 50000.00),
(2, 'Suresh', 'South', 'Mobile', 15000.00),
(3, 'Ramesh', 'North', 'Tablet', 25000.00),
(4, 'Anita', 'East', 'Laptop', 52000.00),
(5, 'Suresh', 'South', 'Headphones', 2000.00),
(6, 'Pooja', 'West', 'Mobile', 14500.00),
(7, 'Anita', 'East', 'Tablet', 24000.00),
(8, 'Ramesh', 'North', 'Headphones', 2500.00);


-- ---------------------------------------------------------
-- STEP 2: SORTING DATA (ORDER BY)
-- ---------------------------------------------------------

-- Case 1: Data ko Amount ke hisaab se ascending (chhote se bada) order me lagana
SELECT * FROM StoreSales 
ORDER BY Amount ASC; 
-- (ASC likhna zaroori nahi hota, wo default hota hai)

-- Case 2: Data ko Amount ke descending (bade se chhota) order me lagana
-- Matlab sabse mehengi sale sabse upar dikhegi
SELECT * FROM StoreSales 
ORDER BY Amount DESC;

-- Case 3: Alphabetical order me sort karna (Salesman ke naam A to Z)
SELECT * FROM StoreSales 
ORDER BY SalesmanName;


-- ---------------------------------------------------------
-- STEP 3: TOP RECORDS NIKALNA (LIMIT)
-- ---------------------------------------------------------

-- Mujhe table ka poora data nahi chahiye, sirf sabse top 3 highest sales dikhao.
-- Iske liye pehle DESC me sort karenge, phir LIMIT 3 laga denge.
SELECT * FROM StoreSales 
ORDER BY Amount DESC 
LIMIT 3;


-- ---------------------------------------------------------
-- STEP 4: AGGREGATE FUNCTIONS (Maths / Calculations)
-- ---------------------------------------------------------

-- 1. COUNT: Table me total kitni sales (rows) hui hain?
SELECT COUNT(*) FROM StoreSales;

-- 2. SUM: Dukaan ki total aamdani (revenue) kitni hui? (Saare Amount ka total)
SELECT SUM(Amount) FROM StoreSales;

-- 3. AVG: Ek average sale kitne rupaye ki hoti hai?
SELECT AVG(Amount) FROM StoreSales;

-- 4. MAX & MIN: Sabse badi sale aur sabse choti sale ka amount kya hai?
SELECT MAX(Amount) FROM StoreSales;
SELECT MIN(Amount) FROM StoreSales;


-- ---------------------------------------------------------
-- STEP 5: DATA KO GROUP KARNA (GROUP BY)
-- ---------------------------------------------------------
-- Ye thoda advanced hai par bahut kaam ka hai!

-- Case 1: Har ek Salesman ne total kitne rupaye ki sale ki?
-- Yahan hum SalesmanName ke base par GROUP bana rahe hain aur unke Amount ka SUM kar rahe hain.
SELECT SalesmanName, SUM(Amount) 
FROM StoreSales 
GROUP BY SalesmanName;

-- Case 2: Har Region (North, South, etc.) se kitni total aamdani aayi?
SELECT Region, SUM(Amount) 
FROM StoreSales 
GROUP BY Region;

-- Case 3: Har Region se kitne items bike? (Count nikalna)
SELECT Region, COUNT(*) 
FROM StoreSales 
GROUP BY Region;