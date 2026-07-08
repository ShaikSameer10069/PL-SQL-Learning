-- =========================================================================
-- 🛠️ DAY 05: SUBQUERIES & VIEWS PRACTICE (HANDS-ON)
-- =========================================================================
-- In tasks ko dhyan se padho aur solve karo.

-- ---------------------------------------------------------
-- TASK 1: CREATE TABLES & INSERT DATA
-- ---------------------------------------------------------
-- Ek 'Products' table aur ek 'Categories' table banao
CREATE TABLE Categories (
    CatID INT PRIMARY KEY,
    CatName VARCHAR(50)
);

CREATE TABLE Gadgets (
    GadgetID INT PRIMARY KEY,
    GadgetName VARCHAR(50),
    Price DECIMAL(10, 2),
    CatID INT
);

-- Data dalte hain
INSERT INTO Categories (CatID, CatName) VALUES (10, 'Laptops'), (20, 'Mobiles');

INSERT INTO Gadgets (GadgetID, GadgetName, Price, CatID) VALUES
(1, 'Dell XPS', 90000.00, 10),
(2, 'iPhone 13', 70000.00, 20),
(3, 'HP Pavilion', 55000.00, 10),
(4, 'Samsung S21', 65000.00, 20);

-- ---------------------------------------------------------
-- TASK 2: WRITE A SUBQUERY
-- ---------------------------------------------------------
-- Sawaal: Wo sabse mehenga gadget kaunsa hai? (Maximum price wale ka naam aur price nikalo)
-- Hint: Pehle MAX(Price) nikalo subquery se, phir usko bahar wali query me match karo.

SELECT GadgetName, Price 
FROM Gadgets 
WHERE Price = (
    SELECT MAX(Price) FROM Gadgets
);

-- ---------------------------------------------------------
-- TASK 3: WRITE ANOTHER SUBQUERY (Using IN)
-- ---------------------------------------------------------
-- Sirf un gadgets ki details nikalo jo 'Laptops' category me aate hain (Subquery ka use karke, JOIN ka nahi).

SELECT * FROM Gadgets 
WHERE CatID IN (
    SELECT CatID FROM Categories WHERE CatName = 'Laptops'
);

-- ---------------------------------------------------------
-- TASK 4: CREATE A VIEW
-- ---------------------------------------------------------
-- Ek 'GadgetDetails' naam ka View banao jisme GadgetName, Price, aur CatName ek sath dikhein (JOIN lagake).

CREATE VIEW GadgetDetails AS
SELECT g.GadgetName, g.Price, c.CatName
FROM Gadgets g
INNER JOIN Categories c 
ON g.CatID = c.CatID;

-- ---------------------------------------------------------
-- TASK 5: SELECT FROM YOUR NEW VIEW
-- ---------------------------------------------------------
-- Apne banaye hue View ko run karke dekho.
SELECT * FROM GadgetDetails;