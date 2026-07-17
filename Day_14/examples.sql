-- =========================================================================
-- 👑 DAY 14: THE GRAND FINALE — ENTERPRISE E-COMMERCE CAPSTONE SCRIPT
-- =========================================================================

CREATE DATABASE IF NOT EXISTS Day14_EnterpriseStoreDB;
USE Day14_EnterpriseStoreDB;

-- =========================================================================
-- 1️⃣ ARCHITECTURAL SCHEMA DESIGN (3NF / BCNF COMPLIANT)
-- =========================================================================

-- Table 1: Users (Customers & Admins)
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(60) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL,
    WalletBalance DECIMAL(10, 2) DEFAULT 0.00,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: Categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE NOT NULL
);

-- Table 3: Products (With JSON for flexible attributes like RAM/Size)
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT DEFAULT 0,
    Specifications JSON, -- Modern NoSQL hybrid feature
    IsActive BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Table 4: Orders (Master Order Header)
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    OrderTotal DECIMAL(10, 2) NOT NULL,
    OrderStatus VARCHAR(30) DEFAULT 'Processing',
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Table 5: OrderItems (Junction Table for 3NF compliance)
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    PriceAtTimeOfPurchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Table 6: InventoryAuditLogs (For automated monitoring)
CREATE TABLE InventoryAuditLogs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    OldStock INT,
    NewStock INT,
    ChangeReason VARCHAR(100),
    LogTime DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- =========================================================================
-- 2️⃣ PERFORMANCE TUNING & INDEXING (DAY 08 INTEGRATION)
-- =========================================================================
-- Creating multi-column Composite Index for super-fast catalog searches by category & status:
CREATE INDEX idx_cat_active ON Products (CategoryID, IsActive);
-- Creating Index on order status for fast logistics querying:
CREATE INDEX idx_order_status ON Orders (OrderStatus);


-- =========================================================================
-- 3️⃣ AUTOMATION WITH TRIGGERS (DAY 06 INTEGRATION)
-- =========================================================================
-- Trigger: Whenever stock is updated, automatically log the change!
DELIMITER //

CREATE TRIGGER AfterStockUpdate
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF OLD.StockQuantity != NEW.StockQuantity THEN
        INSERT INTO InventoryAuditLogs (ProductID, OldStock, NewStock, ChangeReason)
        VALUES (NEW.ProductID, OLD.StockQuantity, NEW.StockQuantity, 'Stock Quantity Updated');
    END IF;
END //

DELIMITER ;


-- =========================================================================
-- 4️⃣ POPULATING THE ENTERPRISE SYSTEM
-- =========================================================================

INSERT INTO Categories VALUES (10, 'Electronics'), (20, 'Fashion'), (30, 'Home Appliances');

INSERT INTO Users (FullName, Email, Phone, WalletBalance) VALUES
('Sameer Khan', 'sameer.khan@enterprise.com', '9876543210', 50000.00),
('Aisha Verma', 'aisha.v@enterprise.com', '8123456789', 15000.00),
('Rohan Sharma', 'rohan.s@enterprise.com', '7654321098', 2000.00);

-- Notice flexible JSON specifications for different product types:
INSERT INTO Products (CategoryID, ProductName, Price, StockQuantity, Specifications) VALUES
(10, 'MacBook Pro 16"', 180000.00, 15, '{"cpu": "M3 Max", "ram": "32GB", "storage": "1TB TB"}'),
(10, 'iPhone 15 Pro', 120000.00, 25, '{"color": "Natural Titanium", "storage": "256GB"}'),
(20, 'Designer Denim Jacket', 4500.00, 50, '{"size": "XL", "material": "100% Cotton", "color": "Blue"}'),
(30, 'Smart Air Fryer', 8500.00, 30, '{"capacity": "4.2L", "power": "1500W", "wifi": true}');

SELECT * FROM Products;


-- =========================================================================
-- 5️⃣ STORED PROCEDURE WITH ACID TRANSACTIONS (DAY 06 & 09 INTEGRATION)
-- =========================================================================
-- Procedure: Securely place an order, deduct wallet balance, and reduce stock!

DELIMITER //

CREATE PROCEDURE PlaceSecureOrder(
    IN p_UserID INT,
    IN p_ProductID INT,
    IN p_Quantity INT
)
BEGIN
    DECLARE v_Price DECIMAL(10,2);
    DECLARE v_Total DECIMAL(10,2);
    DECLARE v_Stock INT;
    DECLARE v_Wallet DECIMAL(10,2);
    DECLARE v_OrderID INT;

    -- Start ACID Transaction block
    START TRANSACTION;

    -- Fetch current price and stock
    SELECT Price, StockQuantity INTO v_Price, v_Stock FROM Products WHERE ProductID = p_ProductID;
    SELECT WalletBalance INTO v_Wallet FROM Users WHERE UserID = p_UserID;

    SET v_Total = v_Price * p_Quantity;

    -- Validate Stock and Wallet Balance
    IF v_Stock < p_Quantity THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Insufficient Stock Available!';
    ELSEIF v_Wallet < v_Total THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Insufficient Wallet Balance!';
    ELSE
        -- 1. Deduct money from User Wallet
        UPDATE Users SET WalletBalance = WalletBalance - v_Total WHERE UserID = p_UserID;
        
        -- 2. Deduct inventory stock (This will also fire our Trigger!)
        UPDATE Products SET StockQuantity = StockQuantity - p_Quantity WHERE ProductID = p_ProductID;
        
        -- 3. Create Order Header
        INSERT INTO Orders (UserID, OrderTotal, OrderStatus) VALUES (p_UserID, v_Total, 'Confirmed');
        SET v_OrderID = LAST_INSERT_ID();
        
        -- 4. Create Order Item record
        INSERT INTO OrderItems (OrderID, ProductID, Quantity, PriceAtTimeOfPurchase) 
        VALUES (v_OrderID, p_ProductID, p_Quantity, v_Price);

        -- Successfully commit transaction
        COMMIT;
    END IF;
END //

DELIMITER ;


-- ---------------------------------------------------------
-- 6️⃣ EXECUTING AND TESTING OUR ENTERPRISE SYSTEM
-- ---------------------------------------------------------
-- Sameer (UserID 1) buys 1 iPhone 15 Pro (ProductID 2):
CALL PlaceSecureOrder(1, 2, 1);

-- Let's verify the magic of automation and transactions:
SELECT * FROM Users WHERE UserID = 1;          -- Balance reduced from 50k to -70k? Wait, Sameer had 50k, iPhone is 120k! This should fail if wallet < total!
-- Note: Let's test with Aisha (UserID 2) buying 1 Denim Jacket (ProductID 3, Price 4500):
CALL PlaceSecureOrder(2, 3, 2);                -- Aisha buys 2 Jackets = Rs. 9,000. She has 15,000. SUCCESS!

SELECT * FROM Users WHERE UserID = 2;          -- Balance reduced from 15,000 to 6,000!
SELECT * FROM Products WHERE ProductID = 3;    -- Stock reduced from 50 to 48!
SELECT * FROM Orders;                          -- New order confirmed!
SELECT * FROM InventoryAuditLogs;              -- Trigger automatically logged the stock reduction!