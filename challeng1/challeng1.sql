SELECT * FROM clients
SELECT * FROM employees
SELECT * FROM products;
SELECT * FROM transactions

# Challenge 1 (easy): Find how many departments and what are they>
# Hent: use employee table

SELECT DISTINCT Department
FROM employees

SELECT  COUNT(DISTINCT Department)
FROM employees

# Challenge 2 (easy): Find the top 10 salaries of employees.

SELECT * FROM employees
ORDER BY salary DESC
LIMIT 10

# Challenge 3 (medium): Find the top 3 sold products.
# Hent: Join two of the tables

SELECT  Product_name, COUNT(Product_name) quantity
FROM transactions t
INNER JOIN  products p 
ON p.Product_id=t.Product_id
GROUP BY Product_name
ORDER BY quantity DESC
LIMIT 3

# Challenge 4 (Hard): Find sales of products in Q2 2023.
# Hent: Join two of the tables

SELECT  p.Product_name, 
		p.Product_price, 
		COUNT(p.Product_name) quantity, 
		p.Product_price* COUNT(p.Product_name) total_sales,
		YEAR(STR_TO_DATE(t.Transaction_time, '%m/%d/%Y')) AS year, 
		QUARTER(STR_TO_DATE(t.Transaction_time, '%m/%d/%Y')) Q
FROM transactions t
INNER JOIN  products p 
ON p.Product_id=t.Product_id
GROUP BY p.Product_name, p.Product_price, year, Q
HAVING YEAR = 2023 AND Q=2
ORDER BY  total_sales DESC
	
# Challenge 5 (Hard): Find the top 10 sales per client in 2023.
# Hent: Join 3 of the tables.

SELECT  c.Client_name, 
		SUM(p.Product_price) customer_total_sales,
        YEAR(STR_TO_DATE(t.Transaction_time, '%m/%d/%Y')) AS year
FROM transactions t
INNER JOIN  products p 
ON p.Product_id=t.Product_id
INNER JOIN  clients c
ON c.Client_id=t.Client_id
GROUP BY c.Client_name, year
HAVING year = 2023
ORDER BY customer_total_sales DESC
LIMIT 10
