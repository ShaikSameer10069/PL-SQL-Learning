-- =========================================================================
-- 📁 DAY 08: INDEXING & PERFORMANCE TUNING (DETAILED EXAMPLES)
-- =========================================================================
-- Note: Direct tables create kar rahe hain active database me.

-- ---------------------------------------------------------
-- STEP 1: SETUP E-COMMERCE TABLE
-- ---------------------------------------------------------
-- Hum ek bade order management system ki table bana rahe hain
CREATE TABLE ECommerceOrders (
    OrderID INT PRIMARY KEY,         -- Primary Key pe automatic Unique Index ban jata hai
    CustomerEmail VARCHAR(100),
    OrderDate DATE,
    OrderStatus VARCHAR(30),         -- E.g., 'Delivered', 'Pending', 'Cancelled'
    TotalAmount DECIMAL(10, 2),
    City VARCHAR(50)
);

-- Data insert karte hain (Imagine karo isme 10 Lakh rows hain!)
INSERT INTO ECommerceOrders (OrderID, CustomerEmail, OrderDate, OrderStatus, TotalAmount, City)
VALUES
(1001, 'sameer@gmail.com', '2026-06-01', 'Delivered', 1500.00, 'Mumbai'),
(1002, 'rahul@yahoo.com', '2026-06-02', 'Pending', 4500.00, 'Delhi'),
(1003, 'priya@gmail.com', '2026-06-02', 'Delivered', 900.00, 'Bangalore'),
(1004, 'neha@outlook.com', '2026-06-03', 'Cancelled', 12000.00, 'Mumbai'),
(1005, 'amit@gmail.com', '2026-06-04', 'Delivered', 3400.00, 'Delhi');

SELECT * FROM ECommerceOrders;


-- =========================================================================
-- 🔥 PART A: NORMAL INDEX CREATION (Fast Searching)
-- =========================================================================

-- Sawaal: Amazon ke dashboard me manager bar-bar ek query chalata hai: 
-- "Delhi me kitne orders aaye?" 
-- Agar table me 10 lakh rows hain, toh bina index ke SQL 10 lakh rows scan karega.

-- ---------------------------------------------------------
-- STEP 2: CREATING AN INDEX ON CITY COLUMN
-- ---------------------------------------------------------
-- Syntax: CREATE INDEX index_ka_naam ON table_ka_naam (column_name);

CREATE INDEX idx_city ON ECommerceOrders (City);

-- Ab agar tum ye query chalaoge, toh ye Makkhan (super fast) chalegi:
SELECT * FROM ECommerceOrders WHERE City = 'Delhi';


-- =========================================================================
-- 🔥 PART B: UNIQUE INDEX CREATION (Speed + No Duplicates)
-- =========================================================================

-- Sawaal: Hum chahte hain ki CustomerEmail se searching fast ho, 
-- aur sath hi koi bhi banda same OrderID ya Email se duplicate entry na kar sake (For logic assumption here).

CREATE UNIQUE INDEX idx_unique_email ON ECommerceOrders (CustomerEmail);

-- Ab CustomerEmail pe searching super fast ho gayi aur koi duplicate email nahi aa sakta!


-- =========================================================================
-- 🔥 PART C: COMPOSITE INDEX (Multi-Column Shortcut)
-- =========================================================================

-- Sawaal: Maan lo hamari sabse zyada chalne wali query ye hai:
-- "Mumbai shahar me kitne orders 'Delivered' ho chuke hain?"
-- Yahan hum WHERE me DO columns use kar rahe hain (City AUR OrderStatus).

-- Single column index se kaam chalega, par BEST performance ke liye Composite Index banate hain:
CREATE INDEX idx_city_status ON ECommerceOrders (City, OrderStatus);

-- Ab ye complex double-condition query lightning fast chalegi:
SELECT * FROM ECommerceOrders 
WHERE City = 'Mumbai' AND OrderStatus = 'Delivered';


-- =========================================================================
-- 🔥 PART D: USING `EXPLAIN` (Analyzing Query Plan)
-- =========================================================================
-- Tumhe kaise pata chalega ki SQL ne tumhara Index use kiya ya nahi?
-- Uske liye query ke aage 'EXPLAIN' laga do!

EXPLAIN SELECT * FROM ECommerceOrders WHERE City = 'Delhi';

-- Output ko read kaise karein?
-- 1. 'possible_keys' aur 'key' column me tumhare index ka naam ('idx_city') dikhega.
-- 2. Agar 'key' me NULL likha hai, matlab SQL ne index use nahi kiya (Full Table Scan hua).
-- 3. Agar 'key' me tumhare index ka naam hai, matlab BADHAI HO! Query optimized hai!


-- =========================================================================
-- 🔥 PART E: DROPPING AN INDEX (Clean up / Removal)
-- =========================================================================
-- Agar koi index faltu padha hai aur INSERT queries ko slow kar raha hai, toh use hata do:

DROP INDEX idx_city ON ECommerceOrders;