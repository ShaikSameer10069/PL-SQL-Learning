-- =========================================================================
-- 🛠️ DAY 04: JOINS PRACTICE (HANDS-ON)
-- =========================================================================
-- Is task me tumhe ek College ka chota sa system banana hai jahan 
-- Students alag table me hain aur unke Courses alag table me.

-- ---------------------------------------------------------
-- TASK 1: DO TABLES CREATE KARO
-- ---------------------------------------------------------
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Branch VARCHAR(50)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    StudentID INT -- Ye column dono tables ko jodega
);

-- ---------------------------------------------------------
-- TASK 2: DATA INSERT KARO
-- ---------------------------------------------------------
INSERT INTO Students (StudentID, StudentName, Branch)
VALUES
(1, 'Ravi', 'Computer Science'),
(2, 'Anjali', 'Mechanical'),
(3, 'Karan', 'Civil'),
(4, 'Sneha', 'Electrical');

INSERT INTO Courses (CourseID, CourseName, StudentID)
VALUES
(101, 'Data Structures', 1),
(102, 'Web Development', 1),
(103, 'Thermodynamics', 2),
(104, 'Machine Learning', 99); -- 99 ek aisa student hai jo abhi admit nahi hua

-- ---------------------------------------------------------
-- TASK 3: INNER JOIN LAGA KAR CHECK KARO
-- ---------------------------------------------------------
-- Sirf un students ka naam aur course dikhao jinke paas valid courses hain.
-- Hint: 'ON s.StudentID = c.StudentID' use karna.

SELECT s.StudentName, s.Branch, c.CourseName
FROM Students s
INNER JOIN Courses c
ON s.StudentID = c.StudentID;

-- ---------------------------------------------------------
-- TASK 4: LEFT JOIN LAGA KAR CHECK KARO
-- ---------------------------------------------------------
-- Saare students ki list dikhao (Karan aur Sneha bhi aane chahiye chahe unka course NULL aaye).

SELECT s.StudentName, s.Branch, c.CourseName
FROM Students s
LEFT JOIN Courses c
ON s.StudentID = c.StudentID;