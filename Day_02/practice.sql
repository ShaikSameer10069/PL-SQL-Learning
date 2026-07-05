-- =========================================================================
-- 🛠️ DAY 02: MASSIVE PRACTICE QUERIES (HANDS-ON EXERCISE)
-- =========================================================================
-- Is file me tumhe khud apna dimaag lagana hai. Niche diye gaye tasks ko 
-- step-by-step follow karo aur run karo.

-- ---------------------------------------------------------
-- TASK 1: CREATE A DETAILED TABLE
-- ---------------------------------------------------------
-- Ek 'LibraryBooks' naam ki table banao jisme ye columns hon:
-- BookID (INT, PRIMARY KEY), BookName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
CREATE TABLE LibraryBooks (
    BookID INT PRIMARY KEY,
    BookName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- ---------------------------------------------------------
-- TASK 2: INSERT BULK DATA
-- ---------------------------------------------------------
-- Is table me kam se kam 7 books ka data daalo.
INSERT INTO LibraryBooks (BookID, BookName, Category, Price)
VALUES
(1, 'Learn SQL', 'Education', 450.00),
(2, 'Rich Dad Poor Dad', 'Finance', 300.00),
(3, 'Harry Potter', 'Fiction', 700.00),
(4, 'JavaScript Basics', 'Education', 550.00),
(5, 'Atomic Habits', 'Self-Help', 400.00),
(6, 'The Hobbit', 'Fiction', 650.00),
(7, 'Python Pro', 'Education', 800.00);

-- ---------------------------------------------------------
-- TASK 3: UPDATE MULTIPLE RECORDS
-- ---------------------------------------------------------
-- Diwali sale chal rahi hai! Saari 'Education' books ka price 50 rupees kam kar do.
UPDATE LibraryBooks 
SET Price = Price - 50 
WHERE Category = 'Education';

-- 'Atomic Habits' book ka price update karke 450 kar do.
UPDATE LibraryBooks 
SET Price = 450.00 
WHERE BookID = 5;

-- ---------------------------------------------------------
-- TASK 4: ALTER THE TABLE STRUCTURE
-- ---------------------------------------------------------
-- Table me ek naya column add karo 'AuthorName' (VARCHAR 100).
ALTER TABLE LibraryBooks 
ADD AuthorName VARCHAR(100);

-- Table me ek aur column add karo 'PublishedYear' (INT).
ALTER TABLE LibraryBooks 
ADD PublishedYear INT;

-- ---------------------------------------------------------
-- TASK 5: DELETE UNWANTED RECORDS
-- ---------------------------------------------------------
-- Maan lo 'The Hobbit' book library se ghum (lost) ho gayi hai. Usko table se uda do.
DELETE FROM LibraryBooks 
WHERE BookID = 6;

-- ---------------------------------------------------------
-- TASK 6: ADVANCED DATA FETCHING (AND / OR / IN)
-- ---------------------------------------------------------
-- Un books ko dhoondo jinki Category 'Fiction' YA (OR) 'Finance' hai.
SELECT * FROM LibraryBooks 
WHERE Category = 'Fiction' OR Category = 'Finance';

-- Un books ko dhoondo jinki Category 'Education' hai AUR (AND) price 500 se zyada hai.
SELECT * FROM LibraryBooks 
WHERE Category = 'Education' AND Price > 500;

-- ---------------------------------------------------------
-- FINAL CHECK
-- ---------------------------------------------------------
-- Sab kuch theek se kaam kar raha hai ya nahi, dekhne ke liye poori table print karo.
SELECT * FROM LibraryBooks;