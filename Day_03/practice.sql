-- =========================================================================
-- 🛠️ DAY 03: ANALYSIS & AGGREGATION PRACTICE (HANDS-ON)
-- =========================================================================
-- Khud se dimaag lagao aur in tasks ko solve karo! 
-- (No Database Creation here, direct Table aur Queries)

-- ---------------------------------------------------------
-- TASK 1: CREATE A SCORES TABLE
-- ---------------------------------------------------------
-- Ek 'GameScores' table banao jisme hum players ka data rakhenge
CREATE TABLE GameScores (
    MatchID INT PRIMARY KEY,
    PlayerName VARCHAR(50),
    Team VARCHAR(50),
    Score INT
);

-- ---------------------------------------------------------
-- TASK 2: INSERT MATCH DATA
-- ---------------------------------------------------------
-- 7 alag-alag matches ka data insert karo
INSERT INTO GameScores (MatchID, PlayerName, Team, Score)
VALUES
(101, 'Virat', 'India', 85),
(102, 'Rohit', 'India', 120),
(103, 'Babar', 'Pakistan', 65),
(104, 'Virat', 'India', 110),
(105, 'Smith', 'Australia', 95),
(106, 'Rohit', 'India', 45),
(107, 'Warner', 'Australia', 78);

-- ---------------------------------------------------------
-- TASK 3: SORTING & LIMIT
-- ---------------------------------------------------------
-- 1. Saare data ko Score ke hisaab se Highest to Lowest (DESC) arrange karo.
SELECT * FROM GameScores 
ORDER BY Score DESC;

-- 2. Sirf Top 2 sabse zyada score karne wale players ki details nikalo.
SELECT * FROM GameScores 
ORDER BY Score DESC 
LIMIT 2;

-- 3. Players ko unke naam ke Alphabetical order me sort karo.
SELECT * FROM GameScores 
ORDER BY PlayerName ASC;

-- ---------------------------------------------------------
-- TASK 4: AGGREGATE MATH CALCULATIONS
-- ---------------------------------------------------------
-- 1. Pata karo ki is table me total kitne matches ka data hai? (COUNT)
SELECT COUNT(*) FROM GameScores;

-- 2. Is poore tournament ka Highest score aur Lowest score kya raha? (MAX, MIN)
SELECT MAX(Score) AS HighestScore, MIN(Score) AS LowestScore 
FROM GameScores;

-- 3. Virat ka total score kitna hua saare matches mila kar? (SUM + WHERE)
SELECT SUM(Score) 
FROM GameScores 
WHERE PlayerName = 'Virat';

-- ---------------------------------------------------------
-- TASK 5: GROUPING DATA (GROUP BY)
-- ---------------------------------------------------------
-- 1. Har Player ne total kitne run banaye? (Group by PlayerName)
SELECT PlayerName, SUM(Score) 
FROM GameScores 
GROUP BY PlayerName;

-- 2. Kis Team ne total milakar sabse zyada run banaye? (Group by Team)
SELECT Team, SUM(Score) 
FROM GameScores 
GROUP BY Team;