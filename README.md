# 📊 Company Database SQL Project

This project builds a comprehensive SQL database system to manage a company's **employees**, **branches**, **clients**, **sales**, and **suppliers**. It also includes advanced SQL functionalities like **joins**, **nested queries**, **wildcards**, **triggers**, and **data manipulation**.

---

## 🏗️ Features

### ✅ Tables Created:

* **employee** – Stores employee details with references to managers and branches.
* **branch** – Contains company branch information and manager assignments.
* **client** – Maintains data about clients and associated branches.
* **works\_with** – Tracks sales between employees and clients (composite key).
* **branch\_supplier** – Records suppliers associated with each branch.
  
* **trigger\_tes** – Logs messages via triggers on employee actions.

---

## 🔐 Constraints & Keys

* **Primary Keys:** All tables have properly defined primary keys.
* **Foreign Keys:** Constraints ensure data integrity (e.g., employee references to manager/supervisor).
* **ON DELETE Actions:**

  * `SET NULL` for non-critical references (e.g., manager deletion).
  * `CASCADE` for dependent data (e.g., sales or suppliers).

---

## 📦 Data Inserted

* Sample data inserted for:

  * Employees (e.g., David Wallace, Michael Scott)
  * Branches (Corporate, Scranton, Stamford)
  * Clients (FedEx, Law Firm, Schools)
  * Sales interactions (`works_with`)
  * Suppliers per branch

---

## 🔍 Queries & Functionalities

### 🔽 Basic Queries

* View all records in `employee`, `client`, `branch_supplier`
* Sorting by `salary`, `sex`, etc.
* Retrieve specific fields using `SELECT`

### 📊 Aggregation & Grouping

* `COUNT`, `SUM`, `AVG` for salary/sales analysis
* Grouped summaries by gender, employee, or client

### 🧠 Wildcards with LIKE

* Search by name patterns (`%LLC`, `%school%`, `LIKE '%a%'`)

### 🔗 Joins

* Combine `employee` and `branch` to get manager names per branch

### 🌀 Nested Queries

* Find employees selling over 30,000
* Get clients of branches managed by a specific employee

### 🔔 Triggers

* Log messages when employees are inserted
* Conditional triggers based on gender using `IF`, `ELSE`

---

## 🧠 Concepts Covered

* Relational Database Design
* Data Normalization
* Primary and Foreign Keys
* Composite Keys
* Triggers and Stored Logic
* Aggregate Functions
* SQL Joins and Nested Queries
* Data Constraints and Integrity

---

## 🚀 How to Run

1. Copy the SQL scripts into your MySQL/MariaDB or compatible SQL editor.
2. Run schema creation queries to build the database.
3. Insert sample data.
4. Execute the queries or add your own for practice and reporting.

---

## 📝 Author

**Ankita Mohan**
[LinkedIn](https://linkedin.com) | [GitHub](https://github.com)
Learning SQL and database design with real-world examples!
