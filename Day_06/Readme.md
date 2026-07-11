# ⚙️ Day 06: Stored Procedures & Triggers (Automating SQL)

Welcome to **Day 06** of our Complete SQL Mastery Series!
Ab tak hum manual queries likh rahe the. Par socho agar ek hi lambi query tumhe din me 50 baar alag-alag values ke sath run karni pade? Ya phir jab bhi koi naya user register kare, toh automatically ek welcome record ban jaye? Aaj hum SQL ko automate karna seekhenge.

---

## 📋 Table of Contents
1. [Objective](#objective)
2. [Concepts Covered in Detail](#concepts-covered-in-detail)
3. [When to use what?](#when-to-use-what)
4. [File Structure](#file-structure)

---

## 🎯 Objective
Aaj ka main focus SQL me code ko save karna aur events pe automatic actions set karna hai:
* **Stored Procedures:** Apna khud ka SQL function banana jisme hum variables (parameters) pass kar sakein.
* **Triggers:** Database me "Action-Reaction" set karna (Jaise hi data INSERT/UPDATE/DELETE ho, waise hi background me koi aur query chal jaye).

---

## 🧠 Concepts Covered in Detail

### 1. Stored Procedures (Code Save Karna)
Stored Procedure ek saved SQL code hota hai jisko tum baar-baar reuse kar sakte ho. Ye bilkul kisi programming language (jaise Python ya C#) ke functions jaisa hota hai.
* **Fayda:** Baar-baar lamba code type nahi karna padta. Tum isme `IN` parameters bhej sakte ho (jaise EmployeeID) aur ye uske hisaab se result dega.
* **Syntax:** `CALL procedure_name(value);` se ye execute ho jata hai.

### 2. Triggers (Auto-Pilot Actions)
Trigger ek special type ka stored procedure hota hai jo *apne aap* chal jata hai jab table me koi specific event hota hai (jaise `AFTER INSERT` ya `BEFORE UPDATE`).
* **Fayda:** Audit trails banane me (kaunsa data kab change hua usko log karne me) ye sabse zyada kaam aata hai.
* **Keywords:** `NEW` (Naya data jo aa raha hai) aur `OLD` (Purana data jo change ya delete ho raha hai).

---

## 💡 When to use what?
* **Stored Procedure:** Jab tumhe apni marzi se (manually ya application ke code se) kisi complex query ko run karna ho.
* **Trigger:** Jab tumhe chahiye ki bina kisi human interference ke, system khud ek action le jab bhi table me chhed-chhad ho.

---

## 📂 File Structure
* 📄 **`examples.sql`**: Is file me `BankAccounts` ki table pe Procedure aur Trigger ka live example diya gaya hai.
* 📄 **`practice.sql`**: Ek solid inventory system ka task jahan tumhe khud automation lagana hai.