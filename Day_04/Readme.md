# 🔗 Day 04: SQL Joins (Connecting Multiple Tables)

Welcome to **Day 04** of our SQL Mastery Series!
Ab tak humne sirf ek akeli table pe operations kiye hain. Lekin asal zindagi me (Amazon, Swiggy, wagaira me) data alag-alag tables me hota hai. Jaise 'Customers' ki table alag aur 'Orders' ki table alag. Aaj hum in alag-alag tables ko jodne (JOIN) ka jaadu seekhenge.

---

## 📋 Table of Contents
1. [Objective](#objective)
2. [Concepts Covered in Detail](#concepts-covered-in-detail)
3. [Real-World Use Case](#real-world-use-case)
4. [File Structure](#file-structure)

---

## 🎯 Objective
Aaj ka goal hai samajhna ki "Primary Key" aur "Foreign Key" ka use karke do alag tables ke data ko ek single result me kaise dikhaya jaye.

---

## 🧠 Concepts Covered in Detail

### 1. `INNER JOIN` (Sirf Matching Data)
Dono tables me jo data match karega, sirf wahi dikhayega.
* *Example:* Sirf un customers ka naam dikhao jinhone koi order place kiya hai.

### 2. `LEFT JOIN` (Left table ka sab kuch)
First (Left) table ka saara data aayega, aur Second (Right) table me se sirf wo aayega jo match ho raha hai. Agar match nahi hua toh wahan `NULL` (khali) likha aayega.
* *Example:* Saare customers ki list dikhao, chahe unhone order kiya ho ya na kiya ho.

### 3. `RIGHT JOIN` (Right table ka sab kuch)
Ye Left Join ka ulta hai. Second (Right) table ka saara data aayega, aur First table se sirf matching data.

### 4. Table Aliases (Shorthand Names)
Baar-baar table ka poora naam likhna lamba ho jata hai, isliye hum tables ko shortcut naam dete hain (jaise `Customers` ko `c` aur `Orders` ko `o`).

---

## 📂 File Structure
* 📄 **`examples.sql`**: Isme `Customers` aur `Orders` ki 2 tables banakar unhe alag-alag tarike se JOIN karke dikhaya gaya hai.
* 📄 **`practice.sql`**: Ek hands-on task jisme tumhe `Students` aur `Courses` tables ko aapas me jodna hai.