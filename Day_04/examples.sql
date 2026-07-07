-- =========================================================================
-- 📁 DAY 04: SQL JOINS (DETAILED EXAMPLES)
-- =========================================================================
-- Note: Isme koi naya database create nahi kar rahe, direct tables banayenge.

-- ---------------------------------------------------------
-- STEP 1: DO TABLES BANANA (Customers aur Orders)
-- ---------------------------------------------------------

-- Pehli Table: Customers (Isme logo ki basic details hongi)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

-- Doosri Table: Orders (Isme khareedari ki details hongi)
-- Yahan 'CustomerID' ye batayega ki kis customer ne order kiya hai (Is column ko Foreign Key kehte hain)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(50),
    Amount DECIMAL(10, 2)
);

-- ---------------------------------------------------------
-- STEP 2: DATA INSERT KARNA
-- ---------------------------------------------------------

-- Customers daalte hain (Dhyan do: Neha aur Rahul ne abhi tak koi order nahi kiya)
INSERT INTO Customers (CustomerID, CustomerName, City)
VALUES
(1, 'Amit Kumar', 'Delhi'),
(2, 'Priya Singh', 'Mumbai'),
(3, 'Neha Sharma', 'Pune'),
(4, 'Rahul Verma', 'Bangalore');

-- Orders daalte hain (Dhyan do: Order 104 kisi guest ne kiya hai jiska CustomerID 99 hai, jo hamari customer list me nahi hai)
INSERT INTO Orders (OrderID, CustomerID, Product, Amount)
VALUES
(101, 1, 'Laptop', 55000.00),
(102, 1, 'Mouse', 800.00),
(103, 2, 'Keyboard', 1500.00),
(104, 99, 'Monitor', 12000.00); 

-- Dono tables ka alag-alag data check karne ke liye:
SELECT * FROM Customers;
SELECT * FROM Orders;


-- ---------------------------------------------------------
-- STEP 3: INNER JOIN (Sirf Matching Data)
-- ---------------------------------------------------------
-- Ye query sirf un logo ko dikhayegi jinka naam Customers table me bhi hai AUR unka order bhi hai.
-- (Neha aur Rahul nahi dikhenge kyunki unka order nahi hai. Guest 99 bhi nahi dikhega.)

SELECT Customers.CustomerName, Customers.City, Orders.Product, Orders.Amount
FROM Customers
INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID;


-- ---------------------------------------------------------
-- STEP 4: ALIASES KA USE KARNA (Shortcuts)
-- ---------------------------------------------------------
-- Upar wali query me 'Customers' aur 'Orders' baar-baar likhna pada. Isko chhota karte hain.
-- Customers = c, Orders = o

SELECT c.CustomerName, c.City, o.Product, o.Amount
FROM Customers c
INNER JOIN Orders o 
ON c.CustomerID = o.CustomerID;


-- ---------------------------------------------------------
-- STEP 5: LEFT JOIN (Saare Customers Dikhne Chahiye)
-- ---------------------------------------------------------
-- Hum chahte hain saare customers ki list aaye, chahe unhone kuch khareeda ho ya nahi.
-- Jinhone kuch nahi khareeda (Neha, Rahul), unke Product aur Amount ki jagah 'NULL' aayega.

SELECT c.CustomerName, c.City, o.Product, o.Amount
FROM Customers c
LEFT JOIN Orders o 
ON c.CustomerID = o.CustomerID;


-- ---------------------------------------------------------
-- STEP 6: RIGHT JOIN (Saare Orders Dikhne Chahiye)
-- ---------------------------------------------------------
-- Hum chahte hain ki dukaan ke saare orders dikhein, chahe wo customer hamari list me ho ya na ho (Jaise Guest 99).

SELECT c.CustomerName, o.OrderID, o.Product, o.Amount
FROM Customers c
RIGHT JOIN Orders o 
ON c.CustomerID = o.CustomerID;