-- =========================================================================
-- 📁 DAY 13: DATABASE NORMALIZATION (1NF TO BCNF ARCHITECTURE)
-- =========================================================================

CREATE DATABASE IF NOT EXISTS Day13_NormalizationDB;
USE Day13_NormalizationDB;

-- =========================================================================
-- ❌ STAGE 0: UNNORMALIZED FORM (UNF - The Messy Disaster)
-- =========================================================================
-- Socho ek anari developer ne college registration ke liye aisi table banayi:
-- Problem: 'Courses' aur 'Professors' column me comma-separated values hain! (Not Atomic)

CREATE TABLE CollegeRegistration_Raw (
    StudentID INT,
    StudentName VARCHAR(50),
    Courses VARCHAR(100),       -- MULTI-VALUED CELL (Violation of 1NF!)
    Professors VARCHAR(100),    -- MULTI-VALUED CELL (Violation of 1NF!)
    ProfessorRoom VARCHAR(50)
);

INSERT INTO CollegeRegistration_Raw VALUES
(1, 'Sameer Khan', 'SQL, Python', 'Dr. Sharma, Dr. Verma', 'Room 101, Room 202'),
(2, 'Aisha Verma', 'Java', 'Dr. Gupta', 'Room 303');


-- =========================================================================
-- 1️⃣ STAGE 1: FIRST NORMAL FORM (1NF - Make Values Atomic)
-- =========================================================================
-- Rule: Har row me single values honi chahiye. No comma-separated data!

CREATE TABLE Step1_1NF_College (
    StudentID INT,
    CourseID INT,
    StudentName VARCHAR(50),
    CourseName VARCHAR(50),
    ProfessorName VARCHAR(50),
    ProfessorRoom VARCHAR(20),
    PRIMARY KEY (StudentID, CourseID) -- Composite Primary Key
);

INSERT INTO Step1_1NF_College VALUES
(1, 101, 'Sameer Khan', 'SQL', 'Dr. Sharma', 'Room 101'),
(1, 102, 'Sameer Khan', 'Python', 'Dr. Verma', 'Room 202'),
(2, 103, 'Aisha Verma', 'Java', 'Dr. Gupta', 'Room 303');

-- ⚠️ PROBLEM IN 1NF (Why we need 2NF?):
-- Yahan StudentName bar-bar repeat ho raha hai! Agar Sameer apna naam change karega, 
-- toh 2 jagah update karna padega (Updation Anomaly).
-- Reason: StudentName sirf StudentID pe depend karta hai, CourseID pe nahi! (Partial Dependency)


-- =========================================================================
-- 2️⃣ STAGE 2: SECOND NORMAL FORM (2NF - Remove Partial Dependency)
-- =========================================================================
-- Rule: Table 1NF me ho + Koi Partial Dependency na ho!
-- Solution: Hum Students ko alag kar denge, aur Course Enrollment ko alag!

-- Table 1: Master Students Table
CREATE TABLE Step2_Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

-- Table 2: Course & Enrollment Table
CREATE TABLE Step2_Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    ProfessorName VARCHAR(50),
    ProfessorRoom VARCHAR(20)
);

-- Table 3: Junction Table (Connecting Students with Courses)
CREATE TABLE Step2_Enrollments (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Step2_Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Step2_Courses(CourseID)
);

-- ⚠️ PROBLEM IN 2NF (Why we need 3NF?):
-- Notice karo Step2_Courses table me: CourseName -> ProfessorName -> ProfessorRoom.
-- Yahan 'ProfessorRoom' directly CourseID pe depend nahi karta, wo 'ProfessorName' pe depend karta hai!
-- A non-key column (ProfessorRoom) depending on another non-key column (ProfessorName) is called 
-- TRANSITIVE DEPENDENCY!


-- =========================================================================
-- 3️⃣ STAGE 3: THIRD NORMAL FORM (3NF - Remove Transitive Dependency)
-- =========================================================================
-- Rule: Table 2NF me ho + No Transitive Dependency! ("Non-key must NOT depend on Non-key").
-- Solution: Professors ko unki alag master table me move kar do!

-- 🌟 FINAL NORMALIZED ARCHITECTURE (3NF / BCNF COMPLIANT) 🌟

-- 1. Master Table: Students
CREATE TABLE Final_Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

-- 2. Master Table: Professors (Transitive dependency removed!)
CREATE TABLE Final_Professors (
    ProfessorID INT PRIMARY KEY,
    ProfessorName VARCHAR(50),
    RoomNumber VARCHAR(20)
);

-- 3. Master Table: Courses (Now linking to ProfessorID)
CREATE TABLE Final_Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    ProfessorID INT,
    FOREIGN KEY (ProfessorID) REFERENCES Final_Professors(ProfessorID)
);

-- 4. Junction Table: Enrollments
CREATE TABLE Final_Enrollments (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Final_Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Final_Courses(CourseID)
);

-- ---------------------------------------------------------
-- STEP 4: INSERTING CLEAN DATA INTO 3NF ARCHITECTURE
-- ---------------------------------------------------------
INSERT INTO Final_Students VALUES (1, 'Sameer Khan'), (2, 'Aisha Verma');
INSERT INTO Final_Professors VALUES (10, 'Dr. Sharma', 'Room 101'), (20, 'Dr. Verma', 'Room 202'), (30, 'Dr. Gupta', 'Room 303');
INSERT INTO Final_Courses VALUES (101, 'SQL Mastery', 10), (102, 'Python Pro', 20), (103, 'Java Core', 30);
INSERT INTO Final_Enrollments (StudentID, CourseID) VALUES (1, 101), (1, 102), (2, 103);


-- ---------------------------------------------------------
-- STEP 5: VERIFYING ARCHITECTURE WITH A MASTER JOIN QUERY
-- ---------------------------------------------------------
-- Ab hamara data 100% clean hai! Koi duplication nahi, koi anomaly nahi!
-- Let's fetch the complete report using JOINs:

SELECT 
    s.StudentName,
    c.CourseName,
    p.ProfessorName,
    p.RoomNumber
FROM Final_Enrollments e
INNER JOIN Final_Students s ON e.StudentID = s.StudentID
INNER JOIN Final_Courses c ON e.CourseID = c.CourseID
INNER JOIN Final_Professors p ON c.ProfessorID = p.ProfessorID;