# 🛡️ Day 12: Database Security, User Administration & Preventing SQL Injection

Welcome to **Day 12** of our Complete SQL Mastery Series! 🚀
Ab tak hum ek Developer ki nazar se SQL dekh rahe थे—queries likhna, joins lagana, aur performance fast karna. Lekin aaj hum **Database Administrator (DBA)** aur **Security Engineer** ka hat pehnेंगे! Real-world enterprise systems (Banking, Defense, E-Commerce) me sabse bada rule hota hai: **"Never trust anyone with your data!"** 

Aaj hum seekhenge ki database ka control kaise manage karte hain aur hackers ke attacks se database ko kaise seal karte hain!

---

## 📋 Table of Contents
1. [Objective](#objective)
2. [The Principle of Least Privilege (PoLP)](#the-principle-of-least-privilege-polp)
3. [Concepts Covered in Detail](#concepts-covered-in-detail)
4. [What is SQL Injection (The #1 Hacker Threat)?](#what-is-sql-injection-the-1-hacker-threat)
5. [File Structure](#file-structure)

---

## 🎯 Objective
Aaj ka main focus database security me best practices implement karna hai:
* **User Management:** Database me naye users create karna aur unka password set karna (`CREATE USER`, `DROP USER`).
* **Permission Control (DCL):** Kis user ko sirf data dekhne ki permission deni hai (`GRANT SELECT`) aur kiske haath se delete karne ka power chhinna hai (`REVOKE DELETE`).
* **SQL Injection Defense:** Aise vulnerable queries ko pehchanna jo hackers ko database hack karne ka moka deti hain, aur unhe **Parameterized Queries** se safe banana.

---

## 🔐 The Principle of Least Privilege (PoLP)
Security ka basic rule hai: **"Jis bande ko jitne kaam ki zaroorat hai, use sirf utni hi permission do, 1% bhi zyada nahi!"**
* **Intern / Junior Dev:** Sirf `SELECT` (read-only) ki permission do. Agar wo `DELETE` ya `DROP` chalane ki koshish kare, toh database use error de dega!
* **Backend Application:** Sirf `SELECT`, `INSERT`, aur `UPDATE` ki permission do. Application ko kabhi `DROP TABLE` ki permission nahi honi chahiye.
* **Lead DBA (Admin):** Sirf inke paas `ALL PRIVILEGES` (root access) hona chahiye.

---

## 🧠 Concepts Covered in Detail

### 1. Data Control Language (DCL - `GRANT` & `REVOKE`)
* **`CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';`**: Naya database account banana.
* **`GRANT permission_type ON database.table TO 'username'@'localhost';`**: User ko power dena (e.g., `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `ALL`).
* **`REVOKE permission_type ON database.table FROM 'username'@'localhost';`**: Di hui power wapas chhinna (Ban kar dena).
* **`SHOW GRANTS FOR 'username'@'localhost';`**: Check karna ki is user ke paas abhi kitni permissions hain.

### 2. SQL Injection (SQLi) - Hackers ka Favorite Weapon
Jab koi hacker tumhare application ke login box ya search bar me normal text ki jagah **malicious SQL code** daal deta hai, use SQL Injection kehte hain.
* **Vulnerable Code Example:** 
  `SELECT * FROM Users WHERE email = '' OR '1'='1' AND password = '';`
  *(Yahan `'1'='1'` hamesha TRUE ho jata hai, aur hacker bina password ke admin login kar leta hai! 😱)*
* **The Fix (Prepared Statements):** Kabhi bhi user ke input ko direct query me join (`CONCAT`) mat karo. Hamesha placeholders (`?` ya `@param`) use karo!

---

## 📂 File Structure
* 📄 **`examples.sql`**: Isme step-by-step naye users banane, unhe permissions dene, wapas chhinne, aur SQL injection ke live examples explain kiye gaye hain.
* 📄 **`practice.sql`**: Ek solid enterprise "Hospital Management System" ka scenario jahan tumhe Doctors, Receptionists aur Interns ke liye security rules setup karne hain!