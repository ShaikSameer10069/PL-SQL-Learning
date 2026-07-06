# 📊 Day 03: Data Analysis, Sorting & Aggregation

Welcome to **Day 03** of our SQL Mastery Series! 
Day 01 aur Day 02 me humne table banane aur data ko manage (Insert/Update/Delete) karne par focus kiya tha. Aaj hum seekhenge ki us data se useful **information** aur **insights** kaise nikalte hain. Data ko sort karna, top records nikalna, aur totals/averages calculate karna aaj ka main target hai.

---

## 📋 Table of Contents
1. [Objective](#objective)
2. [Concepts Covered in Detail](#concepts-covered-in-detail)
3. [Pro Tips](#pro-tips)
4. [File Structure](#file-structure)

---

## 🎯 Objective
Aaj hum database se sawal poochna seekhenge:
* Sabse zyada aamdani (revenue) kis product se hui?
* Data ko A to Z (Alphabetical) ya Z to A kaise lagayein?
* Top 3 highest-paid employees kaun hain?
* Har department ka total kharcha kitna hai?

---

## 🧠 Concepts Covered in Detail

### 1. Sorting Data (`ORDER BY`)
Table ka data default order me aata hai. Agar humein usko apne hisaab se arrange karna hai (jaise sabse mehngi cheez sabse upar):
* **`ASC`**: Chhote se Bada (A-Z, 1-100). Ye default hota hai.
* **`DESC`**: Bade se Chhota (Z-A, 100-1).

### 2. Limiting Results (`LIMIT`)
Agar table me 1 lakh rows hain, par humein sirf top 5 chahiye, toh hum `LIMIT` ka use karte hain. 
* **Syntax:** `SELECT * FROM table ORDER BY column DESC LIMIT 5;`

### 3. Aggregate Functions (Math ka jaadu)
Ye functions poori table ya column ka ek single result nikal ke dete hain:
* **`COUNT()`**: Total kitni rows/items hain?
* **`SUM()`**: Kisi column ka total (jaise total sales).
* **`AVG()`**: Average nikalna.
* **`MIN()` & `MAX()`**: Sabse choti aur sabse badi value dhoondna.

### 4. Grouping Data (`GROUP BY`)
Jab humein same category ke data ko ek sath jod kar uska total ya average nikalna ho.
* *Example:* "Har department (IT, HR, Sales) me kitne log kaam karte hain?"

---

## 📂 File Structure
* 📄 **`examples.sql`**: Is file me upar diye gaye saare commands ko ek `Sales` table banake step-by-step explain kiya gaya hai.
* 📄 **`practice.sql`**: Ek fresh `TournamentScores` table jisme tumhe sorting aur math operations khud try karne hain.