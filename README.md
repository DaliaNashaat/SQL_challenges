# SQL Challenges Repository

This repository contains a set of SQL challenges using the following tables:

- `clients`
- `employees`
- `products`
- `transactions`

All challenges are contained in a single SQL file (`all_challenges.sql`).

---

## Overview of Challenges

### Challenge 1 (Easy): Count Departments
- Find how many departments exist and list them.
- Use the `employees` table.
- Focuses on `DISTINCT` and `COUNT`.

### Challenge 2 (Easy): Top 10 Salaries
- Retrieve the top 10 highest salaries from the `employees` table.
- Practice `ORDER BY` and `LIMIT`.

### Challenge 3 (Medium): Top 3 Sold Products
- Find the three products with the highest quantity sold.
- Requires joining `transactions` and `products`.
- Practice `JOIN`, `GROUP BY`, and `COUNT`.

### Challenge 4 (Hard): Sales in Q2 2023
- Calculate total sales of each product for Q2 of 2023.
- Join `transactions` and `products`.
- Practice `GROUP BY`, `QUARTER`, `YEAR`, and aggregation.

### Challenge 5 (Hard): Top 10 Sales per Client in 2023
- Find the top 10 clients by total sales in 2023.
- Requires joining `transactions`, `products`, and `clients`.
- Practice multi-table `JOIN`, aggregation, and filtering by year.

---

## Notes
- The SQL file `all_challenges.sql` contains all queries together.
- Make sure your date format in the tables matches the expected format (`'%m/%d/%Y'`).
- These challenges are designed to practice basic to advanced SQL skills including joins, aggregation, and filtering.
