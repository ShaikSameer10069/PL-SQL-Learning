-- =========================================================================
-- 🛠️ DAY 14: THE FINAL EXAM — ENTERPRISE ANALYTICS & REPORTING
-- =========================================================================
-- Scenario: The CEO of the company wants advanced analytical reports from 
-- our newly architected Day 14 database schema!

USE Day14_EnterpriseStoreDB;

-- Let's insert a few more orders for rich analytics:
INSERT INTO Orders (UserID, OrderTotal, OrderStatus) VALUES 
(1, 180000.00, 'Delivered'),
(3, 8500.00, 'Shipped');

INSERT INTO OrderItems (OrderID, ProductID, Quantity, PriceAtTimeOfPurchase) VALUES 
(2, 1, 1, 180000.00),
(3, 4, 1, 8500.00);


-- ---------------------------------------------------------
-- 🏆 TASK 1: CREATE AN EXECUTIVE VIEW (DAY 05 INTEGRATION)
-- ---------------------------------------------------------
-- Sawaal: Ek master View banao jiska naam ho 'ExecutiveSalesDashboard'.
-- Is View me OrderID, OrderDate, Customer Name, Product Name, Category Name, 
-- aur Quantity Purchased ek sath JOIN ho kar dikhni chahiye!

CREATE OR REPLACE VIEW ExecutiveSalesDashboard AS
SELECT 
    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    u.FullName AS CustomerName,
    p.ProductName,
    c.CategoryName,
    oi.Quantity,
    oi.PriceAtTimeOfPurchase AS ItemPrice
FROM Orders o
INNER JOIN Users u ON o.UserID = u.UserID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;

-- Test your Executive View:
SELECT * FROM ExecutiveSalesDashboard;


-- ---------------------------------------------------------
-- 🏆 TASK 2: JSON ATTRIBUTE FILTERING (DAY 11 INTEGRATION)
-- ---------------------------------------------------------
-- Sawaal: Product catalog se sirf wo products nikalo jinke JSON specifications me
-- RAM ya Storage define hai, aur unka specific CPU ya Material extract karke print karo!
-- Hint: ->> operator ka use karo.

SELECT 
    ProductName,
    Price,
    Specifications->>'$.ram' AS RAM_Spec,
    Specifications->>'$.storage' AS Storage_Spec,
    Specifications->>'$.material' AS Material_Spec
FROM Products
WHERE Specifications->>'$.ram' IS NOT NULL OR Specifications->>'$.material' IS NOT NULL;


-- ---------------------------------------------------------
-- 🏆 TASK 3: WINDOW FUNCTION ANALYTICS (DAY 07 INTEGRATION)
-- ---------------------------------------------------------
-- Sawaal: Har category me sabse mehenga product kaunsa hai? 
-- `DENSE_RANK()` Window function ka use karke har product ko uski category ke andar
-- Price ke hisaab se rank (Highest to Lowest) do!

SELECT 
    c.CategoryName,
    p.ProductName,
    p.Price,
    DENSE_RANK() OVER(PARTITION BY c.CategoryName ORDER BY p.Price DESC) AS PriceRankInCategory
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;


-- ---------------------------------------------------------
-- 🏆 TASK 4: THE ULTIMATE MASTER CTE (THE GRAND BOOTCAMP TEST)
-- ---------------------------------------------------------
-- Sawaal: Ek master CTE (`WITH` clause) likho jo:
-- 1. Users table se total spend compute kare (SUM of OrderTotal).
-- 2. `CASE WHEN` laga kar Customer Loyalty Tier define kare:
--    - If TotalSpend > 100000 THEN 'Platinum VIP 👑'
--    - If TotalSpend BETWEEN 10000 AND 100000 THEN 'Gold Member 🥇'
--    - ELSE 'Silver Member 🥈'
-- Finally, sort them by TotalSpend in descending order!

WITH CustomerSpendAnalytics AS (
    SELECT 
        u.UserID,
        u.FullName,
        u.Email,
        COALESCE(SUM(o.OrderTotal), 0) AS TotalAmountSpent,
        
        CASE 
            WHEN COALESCE(SUM(o.OrderTotal), 0) >= 100000 THEN 'Platinum VIP 👑'
            WHEN COALESCE(SUM(o.OrderTotal), 0) BETWEEN 10000 AND 99999 THEN 'Gold Member 🥇'
            ELSE 'Silver Member 🥈'
        END AS LoyaltyTier
    FROM Users u
    LEFT JOIN Orders o ON u.UserID = o.UserID
    GROUP BY u.UserID, u.FullName, u.Email
)
SELECT * FROM CustomerSpendAnalytics
ORDER BY TotalAmountSpent DESC;

-- =========================================================================
-- 🎉👑 CONGRATULATIONS! YOU HAVE MASTERED THE 14-DAY BOOTCAMP! 👑🎉
-- =========================================================================