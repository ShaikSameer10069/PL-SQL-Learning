-- =========================================================================
-- 🛠️ DAY 13: SYSTEM DESIGN & NORMALIZATION PRACTICE (HANDS-ON EXERCISE)
-- =========================================================================
-- Scenario: Tum ek e-commerce startup me Lead Database Architect hire hue ho.
-- Purane intern ne saara shopping data ek single messy table me rakh diya tha:

CREATE DATABASE IF NOT EXISTS Day13_PracticeDB;
USE Day13_PracticeDB;

-- ❌ THE MESSY UNNORMALIZED TABLE (Violation of 1NF, 2NF, 3NF):
CREATE TABLE MessyRetailOrders_Raw (
    OrderID INT,
    CustomerName VARCHAR(50),
    CustomerPhone VARCHAR(15),
    CustomerCity VARCHAR(50),
    ProductsBought VARCHAR(150),   -- Comma separated items! (1NF violation)
    SupplierName VARCHAR(50),
    SupplierCity VARCHAR(50)       -- Transitive dependency! (3NF violation)
);

INSERT INTO MessyRetailOrders_Raw VALUES
(5001, 'Sameer Khan', '9876543210', 'Hyderabad', 'Laptop, Wireless Mouse', 'TechSupply Corp', 'Bangalore'),
(5002, 'Rohan Sharma', '8123456789', 'Mumbai', 'Mechanical Keyboard', 'GamingGear Ltd', 'Delhi');


-- ---------------------------------------------------------
-- 🏆 TASK 1: DESIGN THE 3NF NORMALIZED ARCHITECTURE
-- ---------------------------------------------------------
-- Sawaal: Upar diye gaye messy data ko analyze karo aur 4 clean relational 
-- tables design karo jo 3NF / BCNF rules adhere karein:
-- 1. 'Customers' Table (CustomerID, Name, Phone, City)
-- 2. 'Suppliers' Table (SupplierID, SupplierName, SupplierCity)
-- 3. 'Products' Table (ProductID, ProductName, Price, SupplierID as Foreign Key)
-- 4. 'Orders' Table (OrderID, CustomerID, ProductID, OrderDate)
--
-- Write down your CREATE TABLE queries below:

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    CustomerPhone VARCHAR(15) UNIQUE,
    CustomerCity VARCHAR(50)
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(50),
    SupplierCity VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2),
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- ---------------------------------------------------------
-- 🏆 TASK 2: POPULATE YOUR CLEAN ARCHITECTURE
-- ---------------------------------------------------------
-- Sawaal: Apni nayi 4 normalized tables me clean data insert karo taaki 
-- koi duplication ya multi-valued cell na rahe!

INSERT INTO Customers VALUES 
(1, 'Sameer Khan', '9876543210', 'Hyderabad'),
(2, 'Rohan Sharma', '8123456789', 'Mumbai');

INSERT INTO Suppliers VALUES 
(100, 'TechSupply Corp', 'Bangalore'),
(200, 'GamingGear Ltd', 'Delhi');

INSERT INTO Products VALUES 
(10, 'Laptop', 65000.00, 100),
(11, 'Wireless Mouse', 800.00, 100),
(12, 'Mechanical Keyboard', 2500.00, 200);

-- Sameer bought Laptop (10) and Wireless Mouse (11) as separate atomic order rows:
INSERT INTO Orders (OrderID, CustomerID, ProductID) VALUES 
(5001, 1, 10),
(5002, 1, 11),
(5003, 2, 12);


-- ---------------------------------------------------------
-- 🏆 TASK 3: VERIFY WITH AN ARCHITECTURAL JOIN QUERY
-- ---------------------------------------------------------
-- Sawaal: Ek master JOIN query likho jo Orders, Customers, Products aur Suppliers
-- ko aapas me connect karke ek clean receipt generation report print kare!

SELECT 
    o.OrderID,
    o.OrderDate,
    c.CustomerName,
    c.CustomerCity,
    p.ProductName,
    p.Price,
    s.SupplierName AS FulfilledBy
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID;

-- =========================================================================
-- 🎉 DAY 13 COMPLETE! YOU ARE NOW A SYSTEM ARCHITECT & DATABASE DESIGNER! 🏗️
-- =========================================================================