# 📘 PostgreSQL Basics in Bengali (বাংলায় PostgreSQL)

এই ডকুমেন্টটি PostgreSQL ডেটাবেজ সম্পর্কিত কিছু মৌলিক কনসেপ্ট এবং কমান্ডের ব্যবহার বাংলায় ব্যাখ্যা করে।

---

## 1️⃣ PostgreSQL কি?

বর্তমানে ডেটা ব্যবস্থাপনার জন্য **PostgreSQL** একটি বিশ্বস্ত এবং জনপ্রিয় রিলেশনাল ডেটাবেস ম্যানেজমেন্ট সিস্টেম (RDBMS)। এটি শুধু ওপেন সোর্স নয়, বরং একটি শক্তিশালী, স্কেলযোগ্য এবং আধুনিক প্রযুক্তি যা ছোট প্রজেক্ট থেকে শুরু করে এন্টারপ্রাইজ-লেভেল অ্যাপ্লিকেশনে ব্যবহৃত হয়।

### ✅ PostgreSQL-এর কিছু উল্লেখযোগ্য বৈশিষ্ট্য:

- **ক. ওপেন-সোর্স ও ফ্রি:** এটি বিনামূল্যে ব্যবহার ও মডিফাই করা যায়।
- **খ. ক্রস-প্ল্যাটফর্ম:** Linux, Windows, macOS ইত্যাদিতে চলে।
- **গ. এসিআইডি কমপ্লায়েন্ট:** ডাটাবেসের নির্ভরযোগ্যতা ও কনসিসটেন্সি নিশ্চিত করে।
- **ঘ. এক্সটেনসিবল:** ইউজার-ডিফাইন্ড ফাংশন, ডাটা টাইপ ও প্লাগইন যোগ করা যায়।
- **ঙ. পাওয়ারফুল SQL:** জটিল কুয়েরি, সাবকুয়েরি, উইন্ডো ফাংশন ইত্যাদি সমর্থন করে।
- **চ. নিরাপত্তা:** রোল-বেস্ড অ্যাক্সেস কন্ট্রোল, SSL এনক্রিপশন, ডাটা মাস্কিং ইত্যাদি।

---

## 2️⃣ LIMIT এবং OFFSET ক্লজের ব্যবহার

### 🔹 LIMIT ক্লজ:

ডেটা থেকে নির্দিষ্ট সংখ্যক row রিটার্ন করতে ব্যবহৃত হয়।

```sql
SELECT * FROM employees LIMIT 5;
```

🔸 এই কুয়েরিটি `employees` টেবিল থেকে প্রথম ৫টি রো রিটার্ন করবে।

---

### 🔹 OFFSET ক্লজ:

নির্দিষ্ট সংখ্যক row স্কিপ করতে ব্যবহৃত হয়।

```sql
SELECT * FROM employees OFFSET 3;
```

🔸 এটি প্রথম ৩টি রো স্কিপ করে বাকি সব রো রিটার্ন করবে।

---

### 🔹 LIMIT ও OFFSET একসাথে:

ডেটা পেজিনেশনের জন্য ব্যবহৃত হয়।

```sql
SELECT * FROM employees LIMIT 5 OFFSET 10;
```

🔸 এটি ১০টি রো স্কিপ করে পরের ৫টি রো রিটার্ন করবে (তৃতীয় পেজ)।

### ⚠️ গুরুত্বপূর্ণ নোট:

- OFFSET বড় ডেটাসেটে ধীর হতে পারে।
- পারফরম্যান্সের জন্য `Keyset Pagination` বা indexed কলাম ব্যবহার করা উচিত।

---

## 3️⃣ UPDATE স্টেটমেন্ট দিয়ে ডেটা পরিবর্তন

### 🔹 বেসিক সিনট্যাক্স:

```sql
UPDATE টেবিল_নাম
SET কলাম1 = মান1, কলাম2 = মান2, ...
WHERE শর্ত;
```

---

### উদাহরণ ১: একটি কলাম আপডেট

```sql
UPDATE employees
SET salary = 50000
WHERE employee_id = 101;
```

---

### উদাহরণ ২: একাধিক কলাম আপডেট

```sql
UPDATE products
SET price = 1200, stock = stock - 5
WHERE product_id = 'P100';
```

---

### উদাহরণ ৩: সব রেকর্ড আপডেট (সতর্কতা সহ)

```sql
UPDATE customers
SET discount = 0.10;
```

---

### উদাহরণ ৪: অন্য টেবিল থেকে ডেটা নিয়ে আপডেট

```sql
UPDATE orders
SET status = 'completed'
FROM shipments
WHERE orders.order_id = shipments.order_id
AND shipments.ship_date IS NOT NULL;
```

---

### ✅ গুরুত্বপূর্ণ নির্দেশনা:

- **WHERE ক্লজ না থাকলে সব রেকর্ড আপডেট হবে।**
- **UPDATE করার আগে SELECT দিয়ে চেক করুন।**
- **বড় টেবিল আপডেট করার সময় ট্রানজেকশন ও LIMIT ব্যবহার করুন।**

---

## 4️⃣ GROUP BY ক্লজ এবং Aggregation অপারেশন

### 🔹 কাজ:

- ডাটাকে নির্দিষ্ট কলামের উপর ভিত্তি করে গ্রুপ করে
- প্রতিটি গ্রুপে aggregate ফাংশন (SUM, AVG, COUNT, MAX, MIN) প্রয়োগ করা যায়

---

### 🔹 বেসিক সিনট্যাক্স:

```sql
SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1;
```

---

## 5️⃣ Aggregate ফাংশন: COUNT(), SUM(), AVG()

### উদাহরণ ১: প্রতিটি ডিপার্টমেন্টে কর্মচারীর সংখ্যা

```sql
SELECT department, COUNT(*) as employee_count
FROM employees
GROUP BY department;
```

---

### উদাহরণ ২: প্রতিটি ক্যাটাগরির গড় মূল্য

```sql
SELECT category, AVG(price) as average_price
FROM products
GROUP BY category;
```

---

### HAVING দিয়ে গ্রুপ ফিল্টার

```sql
SELECT department, AVG(salary) as avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;
```

---

## 📌 উপসংহার

`GROUP BY`, `LIMIT`, `OFFSET`, এবং `UPDATE` সহ PostgreSQL-এর এই মূল কনসেপ্টগুলো রিলেশনাল ডেটাবেস ব্যবস্থাপনায় অত্যন্ত গুরুত্বপূর্ণ। এই জ্ঞান আপনার SQL দক্ষতা বাড়াতে এবং প্রকৃত প্রজেক্টে ডেটা ম্যানিপুলেশনে সাহায্য করবে।

---
