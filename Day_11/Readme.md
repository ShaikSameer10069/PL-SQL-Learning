# 🚀 Bonus Day 11: Modern SQL - JSON Data Handling & Regex Pattern Matching

Welcome to the **Bonus Day 11** of our Complete SQL Mastery Series! 🎉
Tumhe laga Day 10 pe sab khatam ho gaya? Asli engineers kabhi seekhna band nahi karte! Aaj ke modern full-stack development me, applications (Web, Mobile, APIs) complex nested data produce karti hain. Aaj hum seekhenge ki relational database (SQL) ke andar **NoSQL (JSON)** ki power kaise use karein, aur **Regular Expressions (Regex)** se complex pattern searching kaise karein!

---

## 📋 Table of Contents
1. [Objective](#objective)
2. [Why store JSON in SQL? (The E-Commerce Analogy)](#why-store-json-in-sql-the-e-commerce-analogy)
3. [Concepts Covered in Detail](#concepts-covered-in-detail)
4. [Regular Expressions (`REGEXP`) vs Normal `LIKE`](#regular-expressions-regexp-vs-normal-like)
5. [File Structure](#file-structure)

---

## 🎯 Objective
Aaj ka main focus hai modern 2026 industry requirements ko SQL me implement karna:
* **JSON Columns:** SQL table ke andar JSON data store karna, extract karna (`JSON_EXTRACT`), aur modify karna (`JSON_SET`).
* **Regex Pattern Matching (`REGEXP`):** Text searching ka 'Super Saiyan' mode! Valid Indian phone numbers, emails, ya custom alphanumeric codes ko pattern se filter karna.

---

## 🛒 Why store JSON in SQL? (The E-Commerce Analogy)
Socho tum Amazon ka database design kar rahe ho. Tumhe **Laptop** bechna hai (jisme *RAM, Processor, Graphics Card* hota hai) aur **T-Shirt** bechni hai (jisme *Size, Color, Fabric* hota hai). 
* **Purana Tarika:** Table me 50 columns banao (RAM, Size, Color, Processor...) jisme se T-shirt ke liye RAM wala column khali (`NULL`) padha rahega aur Laptop ke liye Size wala! Yeh bahut messy hai.
* **Modern Tarika (JSON):** Ek single column banao `ProductAttributes` (JSON type ka). Laptop ke liye usme `{ "ram": "16GB", "cpu": "i7" }` daalo aur T-shirt ke liye `{ "size": "XL", "color": "Blue" }`. Ekdum neat aur flexible! 🔥

---

## 🧠 Concepts Covered in Detail

### 1. JSON Functions in SQL
* **`JSON_EXTRACT(column, '$.key')` ya shorthand `->>`:** JSON object ke andar se kisi specific key ki value nikalna (e.g., `Attributes->>'$.color'`).
* **`JSON_SET(column, '$.key', new_value)`:** Table ki row ko delete ya replace kiye bina, JSON ke andar ki kisi value ko update karna.
* **`JSON_ARRAY()` & `JSON_OBJECT()`:** SQL query ke output ko direct JSON format me convert karke API ko bhejna.

### 2. Regular Expressions (`REGEXP` / `RLIKE`)
Normal `LIKE '%khan%'` sirf basic word dhoondta hai. Par **`REGEXP`** se hum rules bana sakte hain:
* **`^` (Caret):** Word yahan se shuru hona chahiye (e.g., `^A` matlab A se shuru hone wale naam).
* **`$` (Dollar):** Word yahan khatam hona chahiye (e.g., `com$` matlab jiske end me 'com' ho).
* **`[0-9]{10}`:** Exact 10 digits ka number hona chahiye (Phone number validation ke liye best!).
* **`[6-9][0-9]{9}`:** Authentic Indian mobile number jo 6, 7, 8, ya 9 se start hota ho!

---

## 📂 File Structure
* 📄 **`examples.sql`**: Isme `TechAppUsers` table ke sath JSON data manipulation aur Regex phone/email validation ka detailed live demo hai.
* 📄 **`practice.sql`**: Ek solid real-world "Food Delivery App (Swiggy/Zomato)" ka task jahan custom orders JSON me store hote hain aur Regex se verification hoti hai.