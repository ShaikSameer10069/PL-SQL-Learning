-- =========================================================================
-- 📁 DAY 10: STRING & DATE WRANGLING + CAPSTONE FINALE (DETAILED EXAMPLES)
-- =========================================================================
-- Note: Direct tables create kar rahe hain active database me.

-- ---------------------------------------------------------
-- STEP 1: SETUP MESSY DATA TABLE FOR CLEANING
-- ---------------------------------------------------------
-- Real world me users aisa hi kachra data form me bharte hain:
CREATE TABLE MessyUsers (
    UserID INT PRIMARY KEY,
    RawFirstName VARCHAR(50),
    RawLastName VARCHAR(50),
    Email VARCHAR(100),
    RegistrationDate DATE,
    LastLoginDate DATE
);

INSERT INTO MessyUsers (UserID, RawFirstName, RawLastName, Email, RegistrationDate, LastLoginDate)
VALUES
(1, '   sameer ', 'KHAN', 'sameer.khan@gmail.com', '2025-01-10', '2026-07-10'),
(2, 'RAHUL', '  verma  ', 'rahul_dev@yahoo.com', '2024-05-15', '2026-06-01'),
(3, '  Priya', 'Singh', 'priya.s@outlook.com', '2026-06-20', '2026-07-12'),
(4, 'amit', 'sharma', 'amit_boss@gmail.com', '2023-11-01', '2024-12-01');

SELECT * FROM MessyUsers;


-- =========================================================================
-- 🔥 PART A: STRING WRANGLING (TEXT CLEANING & MANIPULATION)
-- =========================================================================

-- Case 1: TRIM, UPPER, LOWER, and CONCAT
-- Sawaal: Faltu spaces hatao, pehla naam properly format karo, aur Full Name banao!

SELECT 
    UserID,
    -- TRIM se spaces hate, UPPER se capital hua:
    CONCAT(UPPER(TRIM(RawFirstName)), ' ', UPPER(TRIM(RawLastName))) AS CleanFullName,
    
    -- LOWER se email ko standard small letters me kar diya:
    LOWER(Email) AS StandardEmail
FROM MessyUsers;


-- Case 2: SUBSTRING & LOCATE (Domain Extraction)
-- Sawaal: Mujhe check karna hai ki log kaunsa email provider (Gmail, Yahoo, Outlook) use kar rahe hain.
-- Email me '@' ke baad ka hissa (domain) alag nikalna hai!

SELECT 
    Email,
    -- SUBSTRING(email se nikalna hai, '@' ke baad se, 50 characters tak)
    SUBSTRING(Email, LOCATE('@', Email) + 1) AS EmailDomain
FROM MessyUsers;


-- =========================================================================
-- 🔥 PART B: DATE & TIME WRANGLING (TIME TRAVEL IN SQL)
-- =========================================================================

-- Case 1: DATEDIFF (Calculating Account Age & Activity)
-- Sawaal: Pata karo ki kis user ne Registration ke baad se kitne din tak app use kiya 
-- (RegistrationDate aur LastLoginDate ka difference)!

SELECT 
    TRIM(RawFirstName) AS Name,
    RegistrationDate,
    LastLoginDate,
    DATEDIFF(LastLoginDate, RegistrationDate) AS DaysActive
FROM MessyUsers;


-- Case 2: DATE_ADD & DATE_SUB (Future Expiry Calculation)
-- Sawaal: Maan lo sabhi ko registration pe 30 Days ka Free Trial milta hai. 
-- Sabki "Trial Expiry Date" kya hogi?

SELECT 
    TRIM(RawFirstName) AS Name,
    RegistrationDate,
    DATE_ADD(RegistrationDate, INTERVAL 30 DAY) AS TrialExpiryDate,
    
    -- Sirf Saal (Year) aur Mahina (Month) nikalna ho:
    YEAR(RegistrationDate) AS RegYear,
    MONTHNAME(RegistrationDate) AS RegMonth
FROM MessyUsers;


-- =========================================================================
-- 🏆 PART C: THE GRAND FINALE CAPSTONE PROJECT!
-- =========================================================================
-- Scenario: Hum ek SaaS E-Commerce company ke Database Analyst hain.
-- Hame ek Master Analytical Report banani hai jo:
-- 1. Messy names ko Clean aur Concat kare (String Wrangling).
-- 2. Registration aur Last Login ka gap nikal kar account age banaye (Date Wrangling).
-- 3. CASE WHEN laga kar user loyalty status define kare (Conditional Logic).
-- 4. WITH CTE ka use karke sirf 'VIP Loyal Users' ko filter kare aur unka average active time nikale!

-- HERE IS THE INDUSTRY-GRADE CAPSTONE QUERY:

WITH CleanedUserAnalytics AS (
    SELECT 
        UserID,
        -- Step 1: Clean and format full name
        CONCAT(UPPER(SUBSTRING(TRIM(RawFirstName), 1, 1)), LOWER(SUBSTRING(TRIM(RawFirstName), 2)), ' ', UPPER(SUBSTRING(TRIM(RawLastName), 1, 1)), LOWER(SUBSTRING(TRIM(RawLastName), 2))) AS FormattedName,
        
        -- Step 2: Extract Email Domain
        SUBSTRING(Email, LOCATE('@', Email) + 1) AS Provider,
        
        -- Step 3: Calculate total active duration in months (Approximate by dividing days by 30)
        ROUND(DATEDIFF(LastLoginDate, RegistrationDate) / 30.0, 1) AS ActiveMonths,
        
        -- Step 4: Conditional Logic for Churn & Loyalty Categorization
        CASE 
            WHEN DATEDIFF(LastLoginDate, RegistrationDate) > 365 THEN 'VIP Loyal User 🌟'
            WHEN DATEDIFF(LastLoginDate, RegistrationDate) BETWEEN 180 AND 365 THEN 'Regular Active User 👍'
            ELSE 'High Churn Risk / New ⚠️'
        END AS LoyaltyStatus
    FROM MessyUsers
)
-- Final Output: Fetching our complete master report from the CTE!
SELECT * FROM CleanedUserAnalytics
ORDER BY ActiveMonths DESC;