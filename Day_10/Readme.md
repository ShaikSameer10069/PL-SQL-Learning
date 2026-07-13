# 🎓 Day 10: Advanced String & Date Wrangling + The Grand Finale Capstone!

Welcome to **Day 10**, the final and most exciting module of our Complete SQL Mastery Series! 🚀
Ab tak humne Database creation, Joins, Subqueries, Indexing, aur Transactions sab seekh liya hai. Aaj hum real-world data manipulation ke do sabse common challenges ko tackle karenge: **Uncleaned Text (Strings)** aur **Time/Date calculations**. Saath hi, hum ek **Capstone Analytics Query** likhenge jo hamari 10 din ki mehnat ko ek single industry-grade solution me combine karegi!

---

## 📋 Table of Contents
1. [Objective](#objective)
2. [Why String & Date Wrangling Matters?](#why-string--date-wrangling-matters)
3. [Key Functions Covered](#key-functions-covered)
4. [The Grand Finale: Capstone Project](#the-grand-finale-capstone-project)
5. [File Structure](#file-structure)

---

## 🎯 Objective
Aaj ka main target hai messy data ko clean karna aur time-based analytics nikalna:
* **String Wrangling:** Text ko trim karna, jodna (`CONCAT`), aur email/names se specific parts nikalna (`SUBSTRING`).
* **Date & Time Operations:** Do dates ke beech ka gap nikalna (`DATEDIFF`), future/past dates calculate karna (`DATE_ADD`), aur month/year filter karna.
* **Capstone Integration:** CTE, Joins, Date Math, aur `CASE WHEN` ko ek hi super-query me use karna.

---

## 💡 Why String & Date Wrangling Matters?
Real world me users kabhi clean data nahi daalte! Koi naam capital me likhta hai, koi small me, aur koi aage-peeche spaces chhod deta hai. Usi tarah, E-commerce me "Order Date" aur "Delivery Date" ke beech ka difference nikal kar hi pata chalta hai ki delivery late hui ya fast!

---

## 🧠 Key Functions Covered

### 1. String Functions (Text Operations)
* **`CONCAT(str1, str2)`:** Do ya zyada text words ko ek sath jodna (e.g., First Name + Last Name).
* **`UPPER()` / `LOWER()`:** Saare text ko Capital ya Small letters me convert karna.
* **`TRIM()`:** Text ke aage aur peeche ke faltu spaces ko automatically delete karna.
* **`SUBSTRING(text, start, length)`:** Kisi bade text se ek chhota tukda nikalna (e.g., Email se '@' ke baad ka domain nikalna).
* **`REPLACE(text, old, new)`:** Kisi word ko replace karna.

### 2. Date Functions (Time Operations)
* **`CURRENT_DATE()` / `NOW()`:** System ka aaj ka current date aur time nikalna.
* **`DATEDIFF(date1, date2)`:** Do dates ke beech me kitne din (days) ka difference hai, wo calculate karna.
* **`DATE_ADD(date, INTERVAL 30 DAY)`:** Kisi date me kuch din, mahine, ya saal aage jodna (Subscription expiry nikalne ke liye best!).
* **`YEAR()`, `MONTH()`, `DAY()`:** Kisi date me se sirf Saal, Mahina, ya Din alag nikalna.

---

## 🏆 The Grand Finale: Capstone Project
Is module ke end me hum ek "SaaS Subscription & Churn Analysis" query likhenge. Yeh query:
1. Subquery/CTE ka use karegi.
2. Multiple tables ko JOIN karegi.
3. Date difference nikal kar account age compute karegi.
4. `CASE WHEN` laga kar users ko 'Loyal', 'At Risk', ya 'Churned' me classify karegi!

---

## 📂 File Structure
* 📄 **`examples.sql`**: Isme messy data cleaning, date math, aur Capstone project ka live demonstration hai.
* 📄 **`practice.sql`**: Ek heavy real-world "Netflix/OTT Subscription System" jahan tumhe khud data clean aur churn analytics run karna hai.

---
*🎉 Congratulations on completing the 10-Day SQL Masterclass! You are now industry-ready! 💻✨*