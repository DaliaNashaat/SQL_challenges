SELECT * FROM  members
SELECT * FROM  menu
SELECT * FROM  sales

# 1. What is the total amount each customer spent at the restaurant?
SELECT s.customer_id ,SUM(m.price) AS cus_total_spent
FROM  sales s
INNER JOIN menu m
ON s.product_id=m.product_id
GROUP BY s.customer_id
ORDER BY cus_total_spent DESC

# 2. How many days has each customer visited the restaurant?
SELECT s.customer_id , COUNT(DISTINCT(s.order_date)) AS num_days
FROM  sales s
INNER JOIN menu m
ON s.product_id=m.product_id
GROUP BY s.customer_id
ORDER BY num_days DESC

# 3. What was the first item from the menu purchased by each customer?
SELECT 
    customer_id,
    Product_name
FROM
	(SELECT 
		s.customer_id,
    	m.product_name,
		s.order_date,
		ROW_NUMBER() OVER (
		  PARTITION BY s.customer_id
		  ORDER BY STR_TO_DATE(s.order_date, '%m/%d/%Y')
		) AS rn
	  FROM sales s
	  JOIN menu m
	  ON s.product_id=m.product_id) SUB
	  WHERE rn=1

# 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT m.product_name, COUNT(s.product_id) num_item_purchased
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY num_item_purchased DESC

# 5. Which item was the most popular for each customer?
SELECT   customer_id,
		 Product_name,
         num_item_purchased_customer
FROM
(SELECT s.customer_id,
		m.product_name, 
		COUNT(s.product_id) num_item_purchased_customer,
        RANK() OVER(PARTITION BY s.customer_id ORDER BY COUNT(s.product_id) DESC)  AS rn
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name) SUB
WHERE rn=1
ORDER BY customer_id

# 6. Which item was purchased first by the customer after they became a member?
SELECT customer_id, product_name, order_date
FROM
(SELECT s.customer_id,
		m.product_name,
        s.order_date,
        RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date ) AS date_rank
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
JOIN members b
ON s.customer_id =b.customer_id
WHERE s.order_date>=b.join_date
ORDER BY customer_id
) SUB
WHERE date_rank=1

# 7. Which item was purchased just before the customer became a member?
SELECT customer_id, product_name, order_date
FROM
(SELECT s.customer_id,
		m.product_name,
        s.order_date,
        RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date DESC) AS date_rank
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
JOIN members b
ON s.customer_id =b.customer_id
WHERE s.order_date<b.join_date
ORDER BY customer_id
) SUB
WHERE date_rank=1

# 8. What is the total items and amount spent for each member before they became a member?
SELECT  s.customer_id,
		COUNT(s.product_id) num_total_items,
        SUM(m.price) amount
FROM  sales s
JOIN menu m
ON m.product_id=s.product_id
JOIN members b
ON b.customer_id=s.customer_id
WHERE s.order_date<b.join_date
GROUP BY s.customer_id
ORDER BY  s.customer_id

# 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT * FROM  members
SELECT * FROM  menu
SELECT * FROM  sales
# In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?