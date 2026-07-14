-- =========================================================================
-- 📁 DAY 11: MODERN SQL - JSON HANDLING & REGEX (DETAILED EXAMPLES)
-- =========================================================================
-- Note: Direct tables create kar rahe hain active database me.

-- ---------------------------------------------------------
-- STEP 1: SETUP TABLE WITH JSON COLUMN
-- ---------------------------------------------------------
-- Hum ek modern SaaS Application ki user profile table bana rahe hain
CREATE TABLE TechAppUsers (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    ContactPhone VARCHAR(20),
    -- JSON data type modern MySQL/PostgreSQL me supported hai:
    UserSettings JSON,         -- User ki app preferences (Theme, Notifications, etc.)
    DeviceMetadata JSON        -- Login device ki details
);

-- Bulk JSON Data insert karte hain (Notice the JSON syntax inside single quotes)
INSERT INTO TechAppUsers (UserID, Username, ContactPhone, UserSettings, DeviceMetadata)
VALUES
(1, 'sameer_dev', '9876543210', 
 '{"theme": "dark", "notifications": true, "language": "en", "address": {"city": "Hyderabad", "pincode": 500001}}',
 '{"os": "Windows", "browser": "Chrome", "ip": "192.168.1.1"}'
),
(2, 'rahul_99', '8123456789', 
 '{"theme": "light", "notifications": false, "language": "hi", "address": {"city": "Mumbai", "pincode": 400001}}',
 '{"os": "Mac", "browser": "Safari", "ip": "10.0.0.5"}'
),
(3, 'priya_coder', '5432109876', -- Note: Yeh invalid Indian phone number hai (5 se start ho raha hai)
 '{"theme": "dark", "notifications": true, "language": "en", "address": {"city": "Bangalore", "pincode": 560001}}',
 '{"os": "Linux", "browser": "Firefox", "ip": "172.16.0.1"}'
),
(4, 'amit_boss', '9988776655', 
 '{"theme": "light", "notifications": true, "language": "en", "address": {"city": "Hyderabad", "pincode": 500081}}',
 '{"os": "Windows", "browser": "Edge", "ip": "192.168.1.10"}'
);

SELECT * FROM TechAppUsers;


-- =========================================================================
-- 🔥 PART A: QUERYING INSIDE JSON COLUMNS (`JSON_EXTRACT` & `->>`)
-- =========================================================================

-- Case 1: Extracting simple values from JSON
-- Sawaal: Ek report nikalo jisme Username ke sath uska 'Theme' aur 'OS' dikhe!
-- Syntax: column->>'$.key_name' (shorthand operator to extract clean text)

SELECT 
    Username,
    UserSettings->>'$.theme' AS AppTheme,
    DeviceMetadata->>'$.os' AS OperatingSystem
FROM TechAppUsers;


-- Case 2: Filtering data based on a JSON Key (WHERE clause me JSON)
-- Sawaal: Sirf un users ko dhoondo jinhone 'dark' theme select kiya hai aur jo 'Hyderabad' me rehte hain!
-- Notice karo hum nested JSON address ke andar city kaise nikal rahe hain ('$.address.city'):

SELECT 
    Username,
    UserSettings->>'$.address.city' AS City,
    UserSettings->>'$.theme' AS Theme
FROM TechAppUsers
WHERE UserSettings->>'$.theme' = 'dark' 
  AND UserSettings->>'$.address.city' = 'Hyderabad';


-- Case 3: Modifying a value inside JSON without replacing the whole column (`JSON_SET`)
-- Sawaal: Rahul (UserID 2) ne app me apna theme 'light' se badal kar 'dark' kar diya. 
-- Hame poora JSON string firse likhne ki zaroorat nahi, sirf ek key update karenge:

UPDATE TechAppUsers 
SET UserSettings = JSON_SET(UserSettings, '$.theme', 'dark')
WHERE UserID = 2;

-- Verify karo Rahul ka theme 'dark' ho gaya:
SELECT Username, UserSettings->>'$.theme' AS UpdatedTheme FROM TechAppUsers WHERE UserID = 2;


-- =========================================================================
-- 🔥 PART B: REGULAR EXPRESSIONS (`REGEXP` / `RLIKE` - PRO PATTERN SEARCHING)
-- =========================================================================

-- Case 1: Validating Authentic Indian Phone Numbers
-- Sawaal: Hamare database me kuch logo ne galat phone numbers daal diye hain.
-- Authentic Indian Mobile number ka rule: 
-- 1. Total exact 10 digits hone chahiye.
-- 2. Pehla digit hamesha 6, 7, 8, ya 9 hona chahiye (1 se 5 allow nahi hai).
-- Let's use REGEXP to find VALID vs INVALID phone numbers!

SELECT 
    Username, 
    ContactPhone,
    CASE 
        -- Rule: ^[6-9] matlab 6 se 9 ke beech se shuru ho, [0-9]{9}$ matlab aage exact 9 numbers aur hon:
        WHEN ContactPhone REGEXP '^[6-9][0-9]{9}$' THEN 'Valid Indian Number ✅'
        ELSE 'Invalid / Fake Number ❌'
    END AS PhoneValidationStatus
FROM TechAppUsers;


-- Case 2: Advanced Alphanumeric Searching
-- Sawaal: Un sabhi usernames ko dhoondo jinke naam ke END me digits (numbers) aate hain!
-- Rule: [0-9]+$ matlab naam ka khatam ($) kisi na kisi number pe hona chahiye.

SELECT Username, ContactPhone 
FROM TechAppUsers 
WHERE Username REGEXP '[0-9]+$';