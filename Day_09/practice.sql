-- =========================================================================
-- 🛠️ DAY 09: TRANSACTIONS & CONDITIONAL LOGIC PRACTICE (HANDS-ON)
-- =========================================================================
-- Is task me tumhe ek 'E-Commerce Wallet Checkout System' ko safe banana hai.

-- ---------------------------------------------------------
-- TASK 1: CREATE TABLES & INSERT DATA
-- ---------------------------------------------------------
CREATE TABLE UserWallets (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(50),
    WalletBalance DECIMAL(10, 2)
);

CREATE TABLE OrderHistory (
    OrderID INT PRIMARY KEY,
    UserID INT,
    ItemName VARCHAR(50),
    Price DECIMAL(10, 2),
    Status VARCHAR(20)
);

INSERT INTO UserWallets (UserID, UserName, WalletBalance) VALUES
(1, 'Sameer', 5000.00),
(2, 'John', 1500.00);

SELECT * FROM UserWallets;


-- ---------------------------------------------------------
-- TASK 2: PERFORM A SAFE TRANSACTION (`COMMIT`)
-- ---------------------------------------------------------
-- Sameer (UserID 1) ne ₹1,200 ka ek 'Smartwatch' khareeda.
-- Ek safe transaction likho jo:
-- 1. Sameer ke wallet se ₹1,200 deduct kare.
-- 2. OrderHistory me ek naya record insert kare (OrderID 101, Status 'Confirmed').
-- 3. Sab theek ho toh COMMIT kare.

START TRANSACTION;

UPDATE UserWallets 
SET WalletBalance = WalletBalance - 1200.00 
WHERE UserID = 1;

INSERT INTO OrderHistory (OrderID, UserID, ItemName, Price, Status)
VALUES (101, 1, 'Smartwatch', 1200.00, 'Confirmed');

COMMIT;

-- Verify karo: Sameer ka balance ₹3,800 bacha hona chahiye
SELECT * FROM UserWallets;
SELECT * FROM OrderHistory;


-- ---------------------------------------------------------
-- TASK 3: SIMULATE A FAILED TRANSACTION (`ROLLBACK`)
-- ---------------------------------------------------------
-- John (UserID 2) ke paas sirf ₹1,500 hain. Usne ₹2,000 ka 'Monitor' order kiya.
-- 1. START TRANSACTION karo.
-- 2. John ke wallet se ₹2000 kaato (Balance negative me chala jayega jo galat hai!).
-- 3. Galti realize hote hi ROLLBACK command chala kar balance wapas undo karo!

START TRANSACTION;

-- Galti se paise kaat diye:
UPDATE UserWallets 
SET WalletBalance = WalletBalance - 2000.00 
WHERE UserID = 2;

-- Checkpoint: Arre, balance toh minus me chala gaya! Undo karo!
ROLLBACK;

-- Verify karo: John ka balance safe ₹1,500 hi rehna chahiye
SELECT * FROM UserWallets;


-- ---------------------------------------------------------
-- TASK 4: PRACTICE `CASE WHEN` (Order Categorization)
-- ---------------------------------------------------------
-- Kuch aur orders insert karte hain testing ke liye:
INSERT INTO OrderHistory (OrderID, UserID, ItemName, Price, Status) VALUES
(102, 1, 'Laptop', 65000.00, 'Confirmed'),
(103, 2, 'Mouse', 450.00, 'Confirmed'),
(104, 1, 'Keyboard', 1500.00, 'Confirmed');

-- Sawaal: OrderHistory table se ek report nikalo jisme:
-- ItemName, Price, aur ek naya column ho 'OrderCategory'.
-- Logic: Agar Price > 50000 hai THEN 'Premium Order'
--        Agar Price > 1000 hai THEN 'Standard Order'
--        ELSE 'Budget Order'

SELECT 
    ItemName, 
    Price,
    CASE 
        WHEN Price > 50000 THEN 'Premium Order'
        WHEN Price > 1000 THEN 'Standard Order'
        ELSE 'Budget Order'
    END AS OrderCategory
FROM OrderHistory;