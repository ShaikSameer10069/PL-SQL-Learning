-- =========================================================================
-- 📁 DAY 06: STORED PROCEDURES & TRIGGERS (DETAILED EXAMPLES)
-- =========================================================================

-- ---------------------------------------------------------
-- STEP 1: TABLES SETUP FOR AUTOMATION
-- ---------------------------------------------------------
-- Hum yahan ek Bank Account aur ek Audit Log (History) table bana rahe hain.

CREATE TABLE BankAccounts (
    AccountID INT PRIMARY KEY,
    AccountHolder VARCHAR(50),
    Balance DECIMAL(10, 2)
);

CREATE TABLE TransactionLogs (
    LogID INT AUTO_INCREMENT PRIMARY KEY, -- Ye apne aap 1, 2, 3 badhega
    AccountID INT,
    ActionType VARCHAR(50),
    ActionTime DATETIME DEFAULT CURRENT_TIMESTAMP -- Current date/time apne aap lega
);

-- Ek test account daalte hain
INSERT INTO BankAccounts (AccountID, AccountHolder, Balance) 
VALUES (101, 'Sameer', 5000.00);

SELECT * FROM BankAccounts;


-- =========================================================================
-- 🔥 PART A: STORED PROCEDURES (Custom Functions)
-- =========================================================================

-- Sawaal: Mujhe ek aisa function banana hai jisme main AccountID aur Amount dalu, 
-- aur wo apne aap us account me paise deposit (add) kar de.

-- ---------------------------------------------------------
-- STEP 2: CREATING A PROCEDURE
-- ---------------------------------------------------------
-- DELIMITER // lagana zaroori hai taaki SQL ko pata chale ki procedure kahan khatam ho raha hai.

DELIMITER //

CREATE PROCEDURE DepositMoney (IN acc_id INT, IN dep_amount DECIMAL(10,2))
BEGIN
    -- Ye update query balance badha degi
    UPDATE BankAccounts 
    SET Balance = Balance + dep_amount 
    WHERE AccountID = acc_id;
END //

DELIMITER ;


-- ---------------------------------------------------------
-- STEP 3: CALLING THE PROCEDURE
-- ---------------------------------------------------------
-- Ab Sameer (101) ke account me 2000 rupaye deposit karte hain.
-- Lamba code likhne ki zaroorat nahi, bas PROCEDURE ko CALL karo!

CALL DepositMoney(101, 2000.00);

-- Balance check karo (5000 se 7000 ho gaya hoga)
SELECT * FROM BankAccounts;


-- =========================================================================
-- 🔥 PART B: TRIGGERS (Auto-Pilot Actions)
-- =========================================================================

-- Sawaal: Main chahta hu jab bhi BankAccounts me balance UPDATE ho, 
-- toh apne aap TransactionLogs table me ek entry ho jaye ki "Paisa update hua hai".

-- ---------------------------------------------------------
-- STEP 4: CREATING A TRIGGER
-- ---------------------------------------------------------

DELIMITER //

CREATE TRIGGER AfterBalanceUpdate
AFTER UPDATE ON BankAccounts
FOR EACH ROW
BEGIN
    -- Jab bhi UPDATE hoga, ye INSERT command apne aap chal jayegi
    -- NEW.AccountID matlab jis account me naya update hua hai uska ID
    INSERT INTO TransactionLogs (AccountID, ActionType)
    VALUES (NEW.AccountID, 'Balance Updated');
END //

DELIMITER ;


-- ---------------------------------------------------------
-- STEP 5: TESTING THE TRIGGER
-- ---------------------------------------------------------
-- Ab wapas se Sameer ke account me paise deposit karte hain
CALL DepositMoney(101, 1500.00);

-- Ab check karo! Humne Log table me kuch insert nahi kiya tha, 
-- par Trigger ne apna kaam kar diya hoga.

SELECT * FROM BankAccounts;      -- Balance 8500 ho gaya hoga
SELECT * FROM TransactionLogs;   -- Ek nayi entry apne aap aagayi hogi!