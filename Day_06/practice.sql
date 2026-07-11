-- =========================================================================
-- 🛠️ DAY 06: AUTOMATION PRACTICE (HANDS-ON)
-- =========================================================================
-- Is task me tumhe ek chota sa 'Inventory Management' system banana hai.

-- ---------------------------------------------------------
-- TASK 1: CREATE TABLES
-- ---------------------------------------------------------
-- Ek 'Stock' table aur ek 'SalesHistory' table banao.

CREATE TABLE Stock (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Quantity INT
);

CREATE TABLE SalesHistory (
    HistoryID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    Message VARCHAR(100),
    SaleDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Data insert karo
INSERT INTO Stock (ProductID, ProductName, Quantity) 
VALUES 
(1, 'Laptop', 50),
(2, 'Mouse', 100);


-- ---------------------------------------------------------
-- TASK 2: CREATE A STORED PROCEDURE
-- ---------------------------------------------------------
-- Ek Procedure banao jiska naam ho 'SellProduct'. 
-- Isme IN parameter me (prod_id, sell_qty) aaye.
-- Ye procedure Stock table me se quantity ko MINUS (kam) kar de.

DELIMITER //

CREATE PROCEDURE SellProduct (IN p_id INT, IN s_qty INT)
BEGIN
    UPDATE Stock 
    SET Quantity = Quantity - s_qty 
    WHERE ProductID = p_id;
END //

DELIMITER ;


-- ---------------------------------------------------------
-- TASK 3: CREATE A TRIGGER
-- ---------------------------------------------------------
-- Ek Trigger banao jo Stock table par 'AFTER UPDATE' chale.
-- Jab bhi stock update ho, wo SalesHistory me likh de ki "Stock update hua".

DELIMITER //

CREATE TRIGGER LogStockSale
AFTER UPDATE ON Stock
FOR EACH ROW
BEGIN
    INSERT INTO SalesHistory (ProductID, Message)
    VALUES (NEW.ProductID, 'Stock Quantity has been updated due to a sale.');
END //

DELIMITER ;


-- ---------------------------------------------------------
-- TASK 4: TEST YOUR AUTOMATION
-- ---------------------------------------------------------
-- Ab Laptop (ProductID 1) ki 5 quantity sell karo apne Procedure ka use karke.
CALL SellProduct(1, 5);

-- Ab dono tables check karo! Stock me 45 Laptop bachne chahiye, 
-- aur SalesHistory me ek nayi entry automatically aani chahiye!

SELECT * FROM Stock;
SELECT * FROM SalesHistory;