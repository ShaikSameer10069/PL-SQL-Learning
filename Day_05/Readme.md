# 🚀 Day 05: Subqueries & Views (Advanced SQL)

Welcome to **Day 05** of the SQL Mastery Series!
Ab tak humne basic se lekar Joins tak sab cover kar liya hai. Aaj hum SQL ke do aise powerful features seekhenge jo tumhe ek beginner se Pro bana denge: **Subqueries** aur **Views**.

---

## 📋 Table of Contents
1. [Objective](#objective)
2. [Concepts Covered in Detail](#concepts-covered-in-detail)
3. [When to use what?](#when-to-use-what)
4. [File Structure](#file-structure)

---

## 🎯 Objective
Aaj ka main focus in sawalon ke jawab dena hai:
* Agar mujhe un logo ka data nikalna hai jinki salary "Average Salary" se zyada hai, toh main ek single query me ye kaise karu? (Answer: Subqueries)
* Agar mere paas ek bahut complex JOIN wali query hai jisko mujhe roz run karna padta hai, toh kya main usko chhota/save kar sakta hu? (Answer: Views)

---

## 🧠 Concepts Covered in Detail

### 1. Subqueries (Nested Queries)
Subquery ka matlab hota hai **"Ek Query ke andar doosri Query"**. 
Pehle andar wali (Inner) query chalti hai, aur uska jo result aata hai, use bahar wali (Outer) query use karti hai.
* *Example:* Mujhe wo products dikhao jinka price sabse mehenge product ke price ke barabar hai. 

### 2. Views (Virtual Tables)
View ek asli table nahi hoti, balki ek SQL query ka saved result hoti hai. Ye ek "Virtual Table" ki tarah act karti hai. Agar tum ek bahut lambi 10 line ki JOIN query likhte ho, toh tum usko ek 'View' me save kar sakte ho. Agli baar sirf `SELECT * FROM View_Name` likhna padega.
* **Fayda:** Security (asli table chupa sakte ho) aur Simplicity (complex query ko chhota naam de sakte ho).

---

## 💡 When to use what?
* **Subquery:** Jab ek calculation ke result ke base par doosra data filter karna ho.
* **View:** Jab ek hi complex report (jaise Joins) baar-baar nikalni ho, toh use View banakar save kar lo.

---

## 📂 File Structure
* 📄 **`examples.sql`**: Is file me Subqueries aur Views ko `Employees` aur `Departments` tables ke examples ke sath step-by-step detail me dikhaya gaya hai.
* 📄 **`practice.sql`**: Ek solid hands-on exercise jisme tumhe khud Nested queries aur naye Views banane hain.