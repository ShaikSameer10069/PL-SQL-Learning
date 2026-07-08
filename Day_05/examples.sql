-- =========================================================================
-- 📁 DAY 05: SUBQUERIES AND VIEWS (DETAILED EXAMPLES)
-- =========================================================================
-- Note: Direct tables create kar rahe hain current active database me.

-- ---------------------------------------------------------
-- STEP 1: TABLES SETUP
-- ---------------------------------------------------------
-- Hum yahan ek choti si IT Company ka setup bana rahe hain
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE TechEmployees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10, 2),
    DeptID INT
);

-- ---------------------------------------------------------
-- STEP 2: BULK DATA INSERTION
-- ---------------------------------------------------------
INSERT INTO Departments (DeptID, DeptName)
VALUES 
(1, 'Development'), 
(2, 'Testing'), 
(3, 'HR');

INSERT INTO TechEmployees (EmpID, Name, Salary, DeptID)
VALUES
(101, 'Rohan', 60000.00, 1),
(102, 'Aisha', 45000.00, 2),
(103, 'Kabir', 85000.00, 1),
(104, 'Neha', 40000.00, 3),
(105, 'Aryan', 50000.00, 2),
(106, 'Pooja', 70000.00, 1);

-- Data check kar lo
SELECT * FROM Departments;
SELECT * FROM TechEmployees;


-- =========================================================================
-- 🔥 PART A: SUBQUERIES (QUERY KE ANDAR QUERY)
-- =========================================================================

-- CASE 1: Basic Subquery (WHERE clause me)
-- Sawaal: Un employees ki list dhoondo jinki salary Company ki "Average Salary" se zyada hai.
-- Logic: Pehle (Inner Query) Average salary nikalegi, phir (Outer Query) us average se bade numbers filter karegi.

SELECT Name, Salary 
FROM TechEmployees 
WHERE Salary > (
    SELECT AVG(Salary) FROM TechEmployees
);


-- CASE 2: Subquery with IN operator
-- Sawaal: Un sabhi employees ka naam dhoondo jo 'Development' department me kaam karte hain.
-- Logic: Pehle Inner query 'Development' ka DeptID nikalegi, phir Outer query us ID wale logo ko dhoondegi.

SELECT Name, Salary 
FROM TechEmployees 
WHERE DeptID IN (
    SELECT DeptID FROM Departments WHERE DeptName = 'Development'
);


-- =========================================================================
-- 🔥 PART B: VIEWS (VIRTUAL TABLES / SAVED QUERIES)
-- =========================================================================

-- Sawaal: Mujhe roz Boss ko ek report bhejni padti hai jisme Employee ka naam, 
-- Salary, aur uske Department ka naam sath me ho.
-- Roz roz lambi JOIN query likhna boring hai. Toh hum ek VIEW bana lenge.

-- ---------------------------------------------------------
-- STEP 3: CREATING A VIEW
-- ---------------------------------------------------------
-- Ye command ek 'EmployeeReport' naam ka view (virtual table) bana degi.

CREATE VIEW EmployeeReport AS
SELECT t.EmpID, t.Name, t.Salary, d.DeptName
FROM TechEmployees t
INNER JOIN Departments d 
ON t.DeptID = d.DeptID;


-- ---------------------------------------------------------
-- STEP 4: USING THE VIEW
-- ---------------------------------------------------------
-- Ab jab bhi Boss report mange, tumhe lamba code nahi likhna. 
-- Bas is Virtual Table ko normal table ki tarah call kar lo!

SELECT * FROM EmployeeReport;

-- Tum View ke andar bhi aage filtering kar sakte ho:
-- Jaise sirf unko dikhao jo 'Testing' wale view me hain:
SELECT * FROM EmployeeReport WHERE DeptName = 'Testing';


-- ---------------------------------------------------------
-- STEP 5: DELETING A VIEW (Clean up)
-- ---------------------------------------------------------
-- Agar view ki zaroorat khatam ho jaye:
DROP VIEW EmployeeReport;