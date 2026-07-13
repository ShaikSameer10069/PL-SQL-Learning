-- =========================================================================
-- 🛠️ DAY 10: STRING, DATE & CAPSTONE PRACTICE (THE FINAL EXAM)
-- =========================================================================
-- Is task me tumhe ek 'Netflix / OTT Subscription Platform' ke messy dataset ko 
-- clean karna hai aur ek master analytics report banani hai.

-- ---------------------------------------------------------
-- TASK 1: CREATE TABLE & INSERT MESSY OTT DATA
-- ---------------------------------------------------------
CREATE TABLE OTTSubscribers (
    SubID INT PRIMARY KEY,
    RawUsername VARCHAR(60),
    PlanType VARCHAR(30),
    StartDate DATE,
    LastActiveDate DATE
);

INSERT INTO OTTSubscribers (SubID, RawUsername, PlanType, StartDate, LastActiveDate)
VALUES
(101, '   sameer_netflix   ', 'Premium 4K', '2024-01-01', '2026-07-13'),
(102, 'johnny_dep ', 'Basic Mobile', '2026-06-01', '2026-06-15'),
(103, '  SARA_connor', 'Standard HD', '2025-03-15', '2026-07-01'),
(104, 'rahul_gamer99 ', 'Premium 4K', '2025-11-10', '2025-12-01'),
(105, '   AISHA_queen   ', 'Basic Mobile', '2023-06-01', '2026-07-10');

SELECT * FROM OTTSubscribers;


-- ---------------------------------------------------------
-- TASK 2: STRING WRANGLING PRACTICE (Clean Username)
-- ---------------------------------------------------------
-- Sawaal: Sabhi users ke names se faltu spaces (TRIM) hatao, 
-- unhe lowercase (LOWER) karo, aur aage '@ott_user: ' jod do (CONCAT) taaki standard ID ban jaye!

SELECT 
    SubID,
    CONCAT('@ott_user: ', LOWER(TRIM(RawUsername))) AS StandardizedUsername,
    PlanType
FROM OTTSubscribers;


-- ---------------------------------------------------------
-- TASK 3: DATE WRANGLING PRACTICE (Renewal Calculation)
-- ---------------------------------------------------------
-- Sawaal: Netflix ka plan har 30 din me renew hota hai. 
-- Sabhi users ki StartDate me 30 Days add karke unki "First Renewal Date" nikalo (DATE_ADD use karo).
-- Sath me check karo ki unhone kitne din app use kiya hai (DATEDIFF).

SELECT 
    TRIM(RawUsername) AS CleanName,
    StartDate,
    DATE_ADD(StartDate, INTERVAL 30 DAY) AS FirstRenewalDate,
    DATEDIFF(LastActiveDate, StartDate) AS TotalDaysUsed
FROM OTTSubscribers;


-- ---------------------------------------------------------
-- 🏆 TASK 4: THE FINAL CAPSTONE PRACTICE TASK!
-- ---------------------------------------------------------
-- Sawaal: Ek Master CTE (`WITH` clause) banao jiska naam ho 'NetflixAnalytics'.
-- Us CTE ke andar:
-- 1. Standard Username banao (TRIM karke UPPERCASE me).
-- 2. Total Days Used nikalo (DATEDIFF between LastActiveDate and StartDate).
-- 3. Ek naya column banao 'UserCategory' (CASE WHEN ka use karke):
--    - Agar TotalDaysUsed > 500 hai THEN 'Legendary Subscriber 👑'
--    - Agar TotalDaysUsed BETWEEN 100 AND 500 hai THEN 'Regular Watcher 📺'
--    - ELSE 'Inactive / In Trial ❌'
--
-- Finally, us CTE se SIRF un logo ka data filter karke nikalo 
-- jo 'Premium 4K' plan use karte hain!

WITH NetflixAnalytics AS (
    SELECT 
        SubID,
        UPPER(TRIM(RawUsername)) AS CleanUser,
        PlanType,
        StartDate,
        LastActiveDate,
        DATEDIFF(LastActiveDate, StartDate) AS TotalDaysUsed,
        
        CASE 
            WHEN DATEDIFF(LastActiveDate, StartDate) > 500 THEN 'Legendary Subscriber 👑'
            WHEN DATEDIFF(LastActiveDate, StartDate) BETWEEN 100 AND 500 THEN 'Regular Watcher 📺'
            ELSE 'Inactive / In Trial ❌'
        END AS UserCategory
    FROM OTTSubscribers
)
-- Fetching our filtered analytical output:
SELECT * FROM NetflixAnalytics
WHERE PlanType = 'Premium 4K'
ORDER BY TotalDaysUsed DESC;

-- =========================================================================
-- 🎉 CONGRATULATIONS! YOU HAVE OFFICIALLY MASTERED SQL! 🚀
-- =========================================================================