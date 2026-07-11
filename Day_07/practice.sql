-- =========================================================================
-- 🛠️ DAY 07: ADVANCED ANALYTICS PRACTICE (HANDS-ON)
-- =========================================================================
-- Is task me tumhe ek College Exam Result ka analytical system banana hai.

-- ---------------------------------------------------------
-- TASK 1: CREATE TABLE & INSERT DATA
-- ---------------------------------------------------------
CREATE TABLE ExamResults (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Branch VARCHAR(50),
    Marks INT
);

INSERT INTO ExamResults (StudentID, StudentName, Branch, Marks)
VALUES
(101, 'Rahul', 'Computer Science', 88),
(102, 'Sara', 'Computer Science', 95),
(103, 'Aman', 'Computer Science', 95), -- Sara aur Aman ke marks SAME hain
(104, 'Neha', 'Computer Science', 72),
(105, 'Kabir', 'Mechanical', 80),
(106, 'Pooja', 'Mechanical', 85),
(107, 'Varun', 'Mechanical', 80);      -- Kabir aur Varun ke marks SAME hain

-- ---------------------------------------------------------
-- TASK 2: TRY ALL THREE RANKING FUNCTIONS
-- ---------------------------------------------------------
-- Poore college ke bacchon ko Marks ke hisaab se (Highest to Lowest) rank karo.
-- Query me ROW_NUMBER(), RANK(), aur DENSE_RANK() teeno lagao aur check karo ki ties pe kya difference aa raha hai.

SELECT 
    StudentName, 
    Branch, 
    Marks,
    ROW_NUMBER() OVER(ORDER BY Marks DESC) AS R_Number,
    RANK() OVER(ORDER BY Marks DESC) AS Normal_Rank,
    DENSE_RANK() OVER(ORDER BY Marks DESC) AS Dense_Rank
FROM ExamResults;


-- ---------------------------------------------------------
-- TASK 3: DEPARTMENT-WISE RANKING (Using PARTITION BY)
-- ---------------------------------------------------------
-- Ab college ki overall ranking nahi chahiye! 
-- 'Computer Science' walo ki rank alag nikalo, aur 'Mechanical' walo ki rank alag nikalo.
-- Hint: DENSE_RANK() ke andar OVER(PARTITION BY Branch ORDER BY Marks DESC) use karo.

SELECT 
    StudentName, 
    Branch, 
    Marks,
    DENSE_RANK() OVER(PARTITION BY Branch ORDER BY Marks DESC) AS BranchRank
FROM ExamResults;


-- ---------------------------------------------------------
-- TASK 4: COMBINE CTE + WINDOW FUNCTION (Find Branch Toppers)
-- ---------------------------------------------------------
-- Sawaal: Ek CTE (WITH clause) banao aur usme se SIRF un students ka data nikalo 
-- jo apni-apni branch ke TOP 1 (Rank 1) topper hain!
-- Note: Agar marks same hain toh dono toppers list me aane chahiye! (Hint: DENSE_RANK use karna)

WITH BranchToppers AS (
    SELECT 
        StudentName, 
        Branch, 
        Marks,
        DENSE_RANK() OVER(PARTITION BY Branch ORDER BY Marks DESC) AS RankInBranch
    FROM ExamResults
)
SELECT StudentName, Branch, Marks 
FROM BranchToppers 
WHERE RankInBranch = 1;