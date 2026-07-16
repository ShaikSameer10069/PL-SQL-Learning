# 🏗️ Day 13: Database Design & Normalization (1NF to BCNF)

Welcome to **Day 13** of our Complete SQL Mastery Series! 🚀
Aaj hum coding se ek kadam upar uth kar **Database Architecture** aur **System Design** seekhenge. Agar database ki foundation (tables ka structure) hi galat bani ho, toh dunia ki koi bhi index ya query use fast nahi kar sakti! 

Aaj hum seekhenge ki ek messy, unorganized table ko **Relational Normal Forms (1NF, 2NF, 3NF, BCNF)** ke rules laga kar ek clean, modular aur scalability-ready database me kaise convert karte hain!

---

## 📋 Table of Contents
1. [Objective](#objective)
2. [Why Normalization? (The 3 Deadly Anomalies)](#why-normalization-the-3-deadly-anomalies)
3. [The Normalization Rules (1NF to BCNF)](#the-normalization-rules-1nf-to-bcnf)
4. [File Structure](#file-structure)

---

## 🎯 Objective
Aaj ka main focus database design ki neev (foundation) ko master karna hai:
* **Data Anomalies ko khatam karna:** Insertion, Deletion, aur Updation anomalies se system ko bachana.
* **1NF (First Normal Form):** Atomic values ensure karna (ek cell me comma-separated values nahi honi chahiye).
* **2NF (Second Normal Form):** Partial Dependency remove karna (Composite key ke rules).
* **3NF (Third Normal Form):** Transitive Dependency khatam karna ("No non-key column should depend on another non-key column").
* **BCNF (Boyce-Codd Normal Form):** 3NF ka stricter advance version!

---

## ⚠️ Why Normalization? (The 3 Deadly Anomalies)
Agar hum saara data ek hi table (jaise Excel sheet) me bhar denge, toh 3 khatarnak problems aayengi:
1. **Insertion Anomaly:** Maan lo humne ek naya course launch kiya jisme abhi tak koi student admit nahi hua. Agar table me StudentID primary key hai, toh hum naya course tab tak add nahi kar sakte jab tak koi student admission na le le!
2. **Deletion Anomaly:** Maan lo 'Astronomy' course me sirf 1 student tha aur usne college chhod diya. Uska record delete karte hi hamare database se 'Astronomy' course ki saari details hi permanently gayab ho jayengi!
3. **Updation Anomaly:** Ek Professor ka phone number 500 students ke records me bar-bar repeat ho raha tha. Professor ne number badla, humne 499 jagah update kiya par 1 jagah chhoot gaya! Ab database me galat data ban gaya.

**Solution:** In sabse bachne ke liye hum tables ko **Normalize** karke chote-chote tukdon me todte hain aur unhe Primary/Foreign Keys se jodte hain!

---

## 🧠 The Normalization Rules (1NF to BCNF)

### 1️⃣ 1NF (First Normal Form - Atomic Values)
* **Rule:** Table ka har cell **Atomic** (single value) hona chahiye.
* **Galat:** Ek hi cell me courses = `'SQL, Python, Java'` likhna.
* **Sahi:** Har course ke liye alag row banana taaki har cell me sirf 1 course naam ho.

### 2️⃣ 2NF (Second Normal Form - No Partial Dependency)
* **Rule:** Table pehle se 1NF me honi chahiye, aur kisi bhi non-key column ka **Partial Dependency** nahi hona chahiye!
* **Meaning:** Agar table me Composite Primary Key (`StudentID + CourseID`) hai, toh table ka koi bhi data sirf aadhi key pe depend nahi karna chahiye (e.g., `StudentName` sirf `StudentID` pe depend karta hai, `CourseID` pe nahi). 
* **Fix:** Student ki table alag banao, Course ki alag banao, aur dono ko jodne ke liye ek Junction Table banao!

### 3️⃣ 3NF (Third Normal Form - No Transitive Dependency)
* **Rule:** Table 2NF me honi chahiye, aur **No Transitive Dependency** (Non-key -> Non-key dependency nahi honi chahiye).
* **Meaning:** Ek non-primary key column kisi dusre non-primary key column ko determine nahi karna chahiye. 
* **Example:** Agar table me `CourseName` se `ProfessorName` pata chalta hai, aur `ProfessorName` se `ProfessorRoom` pata chalta hai, toh `ProfessorRoom` indirectly `CourseName` pe depend kar raha hai! 
* **Fix:** Professors ki ek alag independent table bana do!

### 4️⃣ BCNF (Boyce-Codd Normal Form - The Boss Form)
* **Rule:** 3NF ka strictly refined version! For every functional dependency $X \rightarrow Y$, **$X$ must be a Super Key (Candidate Key)**.
* **Meaning:** Koi bhi normal element kisi Primary/Candidate Key ko override ya determine nahi kar sakta.

---

## 📂 File Structure
* 📄 **`examples.sql`**: Isme hum ek messy unnormalized table lenge aur use step-by-step 1NF, 2NF, aur 3NF me transform karke dikhayenge with deep comments!
* 📄 **`practice.sql`**: Ek solid real-world "E-Commerce Retail Architecture" jahan tumhe khud ek messy order table ko normalize karke ER architecture design karna hai!