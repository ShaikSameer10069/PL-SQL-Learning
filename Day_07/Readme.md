# 🏆 Day 07: CTEs (`WITH` Clause) & Window Functions (Pro Analytics)

Welcome to **Day 07** of our Complete SQL Mastery Series!
Aaj hum SQL ka level ekdum top pe le ja rahe hain. Normal queries se hum basic data nikal sakte hain, par jab baat aati hai advanced analytics ki — jaise "Har department me Top 3 highest earners kaun hain?" ya "Complex queries ko clean aur readable kaise banaye?" — tab hum **CTEs** aur **Window Functions** ka use karte hain.

---

## 📋 Table of Contents
1. [Objective](#objective)
2. [Concepts Covered in Detail](#concepts-covered-in-detail)
3. [RANK() vs DENSE_RANK() vs ROW_NUMBER()](#rank-vs-dense_rank-vs-row_number)
4. [File Structure](#file-structure)

---

## 🎯 Objective
Aaj ka target hai complex analytical queries ko simplify karna aur data me ranking system lagana:
* **CTEs (`WITH` Clause):** Lambi aur complex Subqueries ko chhota, readable, aur professional banana.
* **Window Functions:** Bina rows ko collapse kiye (`GROUP BY` ki tarah data chupaaye bina), har row ke sath analytical calculations karna.

---

## 🧠 Concepts Covered in Detail

### 1. CTE - Common Table Expression (`WITH` Clause)
CTE ek **Temporary Virtual Table** hoti hai jo sirf us query ke execution tak zinda rehti hai. Isko `WITH` keyword se shuru karte hain. 
* **Fayda:** Agar tumhare paas query ke andar query (Subquery) hai jo padhne me bahut confusing lag rahi hai, toh CTE usko step-by-step clean blocks me tod deta hai. Ye modern developers ka favorite tool hai!

### 2. Window Functions (`OVER()`, `PARTITION BY`)
Normal `GROUP BY` lagane se rows kam ho jati hain aur sirf summary dikhti hai. Par **Window Functions** table ki har row ko banaye rakhte hue uske samne calculation (jaise running total ya rank) dikhate hain.
* **`PARTITION BY`**: Ye `GROUP BY` ka chhota bhai hai jo window function ke andar categories banata hai (e.g., Har department ke hisaab se alag ranking karna).

---

## 🥇 RANK() vs DENSE_RANK() vs ROW_NUMBER()
Ye interview ka sabse famous sawal hai! Maan lo 3 logo ke marks hain: 90, 90, aur 85.
* **`ROW_NUMBER()`**: Ye bas line se number dega, bina marks dekhe. (Rank: 1, 2, 3)
* **`RANK()`**: Equal marks walo ko same rank dega, par agla number **skip** kar dega! (Rank: 1, 1, 3 -> *Notice karo 2 gayab hai*)
* **`DENSE_RANK()`**: Equal marks walo ko same rank dega aur koi number **skip nahi karega**! (Rank: 1, 1, 2 -> *Best for real-world ranking*)

---

## 📂 File Structure
* 📄 **`examples.sql`**: Isme `SalesAnalytics` table ke sath CTE aur Ranking functions ka live demonstration hai.
* 📄 **`practice.sql`**: Ek solid `StudentExamResults` ka task jisme tumhe khud ranking aur CTEs apply karne hain.