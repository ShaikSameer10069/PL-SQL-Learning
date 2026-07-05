# 🚀 Day 02: Advanced Data Manipulation & Table Structure

Welcome to **Day 02** of our Complete SQL Mastery Series! 
Day 01 me humne apna pehla database aur table banaya tha, aur data daalna seekha tha. Aaj hum database ke real-world operations seekhenge. Ek baar jab data table me chala jata hai, toh usko modify karna, galat data ko delete karna, aur table ke design ko badalna aana chahiye.

---

## 📋 Table of Contents
1. [Objective](#objective)
2. [Concepts Covered in Detail](#concepts-covered-in-detail)
3. [Best Practices & Pro Tips](#best-practices--pro-tips)
4. [File Structure](#file-structure)

---

## 🎯 Objective
Aaj ka main focus in cheezon par hai:
* **Modifying Existing Data:** Purane data ko naye data se replace karna.
* **Cleaning Up Data:** Unwanted ya galat data ko permanently remove karna.
* **Schema Evolution:** Bani hui table me naye columns add karna, ya purane hata dena.
* **Advanced Filtering:** Multiple conditions laga kar exact data find karna.

---

## 🧠 Concepts Covered in Detail

### 1. The `UPDATE` Command (Data badalna)
Jab bhi kisi ka naam, salary, ya price update karna ho, hum `UPDATE` use karte hain.
* **Syntax:** `UPDATE table_name SET column1 = value1 WHERE condition;`
* ⚠️ **DANGER:** Agar `WHERE` condition bhool gaye, toh table ka poora data change ho jayega!

### 2. The `DELETE` Command (Data hatana)
Faltu rows ko delete karne ke liye.
* **Syntax:** `DELETE FROM table_name WHERE condition;`
* ⚠️ **DANGER:** Bina `WHERE` clause ke `DELETE` chalane se table ki saari rows ud jayengi.

### 3. The `ALTER TABLE` Command (Table ka dhancha badalna)
Table banne ke baad usme changes karna.
* **ADD Column:** Naya column jodna (e.g., `ALTER TABLE table_name ADD column_name datatype;`)
* **DROP Column:** Kisi existing column ko hatana.
* **MODIFY Column:** Column ka datatype ya size change karna.

### 4. Logical Operators (`AND`, `OR`, `IN`)
Ek se zyada conditions lagane ke liye in operators ka use hota hai jisse hum pinpoint accuracy se data nikal sakein.

---

## 💡 Best Practices & Pro Tips
* Hamesha `UPDATE` ya `DELETE` chalane se pehle `SELECT` query chala kar dekh lo ki wahi data aa raha hai jo tum change/delete karna chahte ho.
* Table banate waqt future ka soch kar datatype chuno.
* Primary Key wale columns ko kabhi `UPDATE` nahi karna chahiye.

---

## 📂 File Structure
* 📄 **`examples.sql`**: Detailed practical examples with extreme explanations.
* 📄 **`practice.sql`**: A massive task to test your Day 02 skills.