# 🛡️ Day 09: Database Transactions (ACID) & Conditional Logic (`CASE WHEN`)

Welcome to **Day 09** of our Complete SQL Mastery Series!
Aaj hum database safety aur advanced data categorization seekhenge. Jab hum real-world financial applications (Banking, E-commerce, Swiggy/Zomato) banate hain, tab data accuracy aur safety sabse badi priority hoti hai. Ek galti aur lakho ka nuksan ho sakta hai.

---

## 📋 Table of Contents
1. [Objective](#objective)
2. [What are ACID Properties? (The Gold Standard)](#what-are-acid-properties-the-gold-standard)
3. [Concepts Covered in Detail](#concepts-covered-in-detail)
4. [File Structure](#file-structure)

---

## 🎯 Objective
Aaj ka main focus in do fundamental super-skills par hai:
* **Transaction Control Language (TCL):** `COMMIT`, `ROLLBACK`, aur `SAVEPOINT` ka use karke database operations ko safe banana.
* **Conditional Logic (`CASE WHEN`):** SQL query ke andar hi Python ya C++ jaise `IF-ELSE` statements lagakar dynamic columns aur reports generate karna.

---

## 💎 What are ACID Properties? (The Gold Standard)
Kisi bhi reliable database ko **ACID** rules follow karne padte hain:
* **A - Atomicity (Ya toh pura kaam hoga, ya bilkul nahi):** Agar ek transaction me 3 steps hain aur step 3 fail ho gaya, toh step 1 aur 2 bhi apne aap cancel (`ROLLBACK`) ho jayenge.
* **C - Consistency:** Transaction khatam hone ke baad data valid state me rehna chahiye (Bank ka total balance same rehna chahiye).
* **I - Isolation:** Do log ek hi waqt pe same account se paise nikal rahe hain, toh dono transactions ek dusre ko disturb nahi karenge.
* **D - Durability:** Ek baar data save (`COMMIT`) ho gaya, toh server crash hone ke baad bhi data delete nahi hoga.

---

## 🧠 Concepts Covered in Detail

### 1. Transactions (`START TRANSACTION`, `COMMIT`, `ROLLBACK`)
* **`START TRANSACTION` (ya `BEGIN`):** Yahan se safety mode on hota hai. Jab tak tum final command nahi doge, database me koi bhi change permanent nahi hoga.
* **`COMMIT`:** Sab kuch sahi se ho gaya! Changes ko permanently database me save kar do.
* **`ROLLBACK`:** Kuch gadbad ho gayi ya error aa gaya! Saare changes ko cancel karke wahi wapas le jao jahan se start kiya tha (Undo button ki tarah).
* **`SAVEPOINT`:** Lamba transaction hai? Beech me ek checkpoint bana lo taaki agar aage galti ho, toh shuruwat se nahi balki us checkpoint tak hi undo karna pade.

### 2. Conditional Logic (`CASE WHEN... THEN... ELSE... END`)
SQL ka apna **If-Else statement**! Isse hum existing data ke basis pe naye dynamic columns bana sakte hain.
* *Example:* Agar Salary > 80,000 hai `THEN 'High Earner'`, Agar 50,000 se zyada hai `THEN 'Mid Earner'`, `ELSE 'Junior Earner'`.

---

## 📂 File Structure
* 📄 **`examples.sql`**: Isme bank money transfer ka live scenario aur `CASE WHEN` ka detailed demonstration hai.
* 📄 **`practice.sql`**: Ek solid E-Commerce order checkout system jahan tumhe khud transaction failures aur dynamic categories handle karni hain.