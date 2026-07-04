-- ==========================================
-- Day 01: Practice Queries
-- ==========================================

-- Task 1: Ek 'Students' naam ka table banao jisme StudentID, Name, Age, aur City columns hon.
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    City VARCHAR(50)
);

-- Task 2: Us Students table me 3 logo ka data daalo.
INSERT INTO Students (StudentID, Name, Age, City)
VALUES
(101, 'Ravi Kumar', 20, 'Delhi'),
(102, 'Kiran Rao', 22, 'Mumbai'),
(103, 'Aman Gupta', 21, 'Pune');

-- Task 3: Saare students ka sirf Name aur Age dekho.
SELECT Name, Age FROM Students;

-- Task 4: Sirf un students ka data nikalo jo 'Delhi' se hain.
SELECT * FROM Students WHERE City = 'Delhi';