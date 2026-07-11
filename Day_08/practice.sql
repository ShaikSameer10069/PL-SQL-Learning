-- =========================================================================
-- 🛠️ DAY 08: INDEXING & OPTIMIZATION PRACTICE (HANDS-ON)
-- =========================================================================
-- Is task me tumhe ek 'Social Media / User Profile' system ko optimize karna hai.

-- ---------------------------------------------------------
-- TASK 1: CREATE TABLE & INSERT DATA
-- ---------------------------------------------------------
CREATE TABLE UsersProfile (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    PhoneNumber VARCHAR(15),
    Country VARCHAR(50),
    AccountStatus VARCHAR(20),       -- E.g., 'Active', 'Banned', 'Suspended'
    RegistrationDate DATE
);

INSERT INTO UsersProfile (UserID, Username, PhoneNumber, Country, AccountStatus, RegistrationDate)
VALUES
(1, 'sameer_coder', '9876543210', 'India', 'Active', '2025-01-15'),
(2, 'john_doe', '8765432109', 'USA', 'Active', '2025-02-10'),
(3, 'prahul_99', '7654321098', 'India', 'Banned', '2025-03-12'),
(4, 'sara_connor', '6543210987', 'UK', 'Active', '2025-04-20'),
(5, 'aisha_khan', '5432109876', 'India', 'Active', '2025-05-05');


-- ---------------------------------------------------------
-- TASK 2: CREATE A UNIQUE INDEX
-- ---------------------------------------------------------
-- Social media pe kisi ka bhi 'PhoneNumber' same nahi hona chahiye.
-- Ek UNIQUE INDEX banao 'PhoneNumber' column ke upar jiska naam ho 'idx_unique_phone'.

CREATE UNIQUE INDEX idx_unique_phone ON UsersProfile (PhoneNumber);


-- ---------------------------------------------------------
-- TASK 3: CREATE A NORMAL INDEX FOR REGULAR SEARCHING
-- ---------------------------------------------------------
-- Admin bar-bar check karta hai ki "India se kitne users hain?"
-- 'Country' column ke upar ek regular INDEX banao jiska naam ho 'idx_country'.

CREATE INDEX idx_country ON UsersProfile (Country);


-- ---------------------------------------------------------
-- TASK 4: CREATE A COMPOSITE INDEX FOR COMPLEX QUERIES
-- ---------------------------------------------------------
-- Sabse frequent analytical query ye hai:
-- "India me kitne users ka AccountStatus 'Active' hai?"
-- Country aur AccountStatus ko mila kar ek COMPOSITE INDEX banao ('idx_country_status').

CREATE INDEX idx_country_status ON UsersProfile (Country, AccountStatus);


-- ---------------------------------------------------------
-- TASK 5: VERIFY YOUR INDEX WITH `EXPLAIN`
-- ---------------------------------------------------------
-- Ab niche di gayi query ke aage 'EXPLAIN' laga kar check karo 
-- ki database hamare banaye hue composite index ('idx_country_status') ko pick kar raha hai ya nahi!

EXPLAIN SELECT * FROM UsersProfile 
WHERE Country = 'India' AND AccountStatus = 'Active';


-- ---------------------------------------------------------
-- TASK 6: DROP AN UNNECESSARY INDEX
-- ---------------------------------------------------------
-- Maan lo company ne decide kiya ki ab hume 'idx_country' wale single index ki zaroorat nahi hai 
-- kyunki composite index humara kaam kar dega. Toh purane index ko DROP kar do!

DROP INDEX idx_country ON UsersProfile;