-- =========================================================================
-- 🛠️ DAY 11: MODERN JSON & REGEX PRACTICE (THE PRO DEVELOPER TEST)
-- =========================================================================
-- Is task me tumhe ek Food Delivery Platform (Zomato/Swiggy style) ka 
-- complex JSON order management system handle karna hai.

-- ---------------------------------------------------------
-- TASK 1: CREATE TABLE & INSERT JSON FOOD ORDERS
-- ---------------------------------------------------------
CREATE TABLE FoodOrders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    DeliveryPhone VARCHAR(20),
    OrderDetails JSON,        -- Customization details stored as JSON
    BillAmount DECIMAL(10, 2)
);

INSERT INTO FoodOrders (OrderID, CustomerName, DeliveryPhone, OrderDetails, BillAmount)
VALUES
(101, 'Sameer Khan', '9876543210', 
 '{"item": "Chicken Biryani", "spice_level": "High", "extra_raita": true, "cutlery_needed": false}', 
 350.00
),
(102, 'John Doe', '1234567890', -- Invalid Phone Number
 '{"item": "Paneer Butter Masala", "spice_level": "Mild", "extra_raita": false, "cutlery_needed": true}', 
 280.00
),
(103, 'Aisha Verma', '8899776655', 
 '{"item": "Chicken Biryani", "spice_level": "Medium", "extra_raita": true, "cutlery_needed": true}', 
 380.00
),
(104, 'Rohan Sharma', '987654', -- Incomplete Phone Number
 '{"item": "Veg Fried Rice", "spice_level": "High", "extra_raita": false, "cutlery_needed": false}', 
 220.00
);

SELECT * FROM FoodOrders;


-- ---------------------------------------------------------
-- TASK 2: QUERYING JSON DATA (Filter Spicy Biryani Orders)
-- ---------------------------------------------------------
-- Sawaal: Kitchen manager ko sirf wo orders dekhne hain jisme:
-- 1. Item 'Chicken Biryani' ho.
-- 2. Spice Level 'High' ya 'Medium' ho.
-- Query likho jo OrderID, CustomerName, Item, aur Spice Level (JSON se nikal kar) dikhaye!
-- Hint: OrderDetails->>'$.item' ka use karo.

SELECT 
    OrderID,
    CustomerName,
    OrderDetails->>'$.item' AS FoodItem,
    OrderDetails->>'$.spice_level' AS SpiceLevel
FROM FoodOrders
WHERE OrderDetails->>'$.item' = 'Chicken Biryani'
  AND OrderDetails->>'$.spice_level' IN ('High', 'Medium');


-- ---------------------------------------------------------
-- TASK 3: MODIFYING JSON DATA (`JSON_SET`)
-- ---------------------------------------------------------
-- Sawaal: Sameer (OrderID 101) ne restaurant me call karke bola ki usko 
-- 'cutlery_needed' ko 'false' se badal kar 'true' karna hai!
-- `JSON_SET` ka use karke OrderID 101 ka JSON data update karo!

UPDATE FoodOrders 
SET OrderDetails = JSON_SET(OrderDetails, '$.cutlery_needed', true)
WHERE OrderID = 101;

-- Verify karo ki cutlery_needed ab 'true' ho gaya hai:
SELECT OrderID, CustomerName, OrderDetails->>'$.cutlery_needed' AS CutleryRequired 
FROM FoodOrders WHERE OrderID = 101;


-- ---------------------------------------------------------
-- TASK 4: REGEX PATTERN MATCHING (Delivery Phone Verification)
-- ---------------------------------------------------------
-- Sawaal: Delivery boy nikalne se pehle check karna hai ki kis customer ka phone number 
-- ekdum sahi (Exact 10 digits aur starting from 6, 7, 8, 9) hai aur kiska fake/invalid hai.
-- REGEXP ka use karke ek report nikalo jisme CustomerName, DeliveryPhone, 
-- aur 'VerificationStatus' likha ho!

SELECT 
    OrderID,
    CustomerName,
    DeliveryPhone,
    CASE 
        WHEN DeliveryPhone REGEXP '^[6-9][0-9]{9}$' THEN 'Ready for Delivery '
        ELSE 'Call Customer Care - Invalid Number '
    END AS VerificationStatus
FROM FoodOrders;

-- =========================================================================
-- 🎉 BONUS DAY 11 COMPLETE! YOU ARE A TRUE MODERN FULL-STACK PRO! 💻🔥
-- =========================================================================