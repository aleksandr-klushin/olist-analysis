SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT review_id) AS uniq_review_id,
       COUNT(DISTINCT (review_id, order_id)) AS uniq_pairs
FROM order_reviews;

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT customer_id) AS uniq_customer_id,
       COUNT(DISTINCT customer_unique_id) AS uniq_customer_unique_id
FROM customers;

SELECT customer_unique_id, COUNT(order_id)
FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY customer_unique_id
HAVING COUNT(order_id) > 1;

WITH per_client AS (
    SELECT c.customer_unique_id, COUNT(*) AS orders_cnt
    FROM orders o
    JOIN customers c ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT orders_cnt, COUNT(*) AS clients
FROM per_client
GROUP BY orders_cnt
ORDER BY orders_cnt;


SELECT order_status, COUNT(order_id) as orders_cnt, 
      TRUNC(COUNT(order_id) * 1.0 / SUM(COUNT(*)) OVER () * 100, 2) as pct_of_total
FROM orders
GROUP BY order_status 
ORDER BY orders_cnt DESC;


SELECT COUNT(order_id) as bad_date
FROM orders
WHERE order_purchase_timestamp > order_delivered_customer_date;

SELECT COUNT(order_id) as none_date
FROM orders
WHERE order_status = 'delivered' and order_delivered_customer_date IS NULL;

SELECT order_status, COUNT(order_id) as orders_cnt
FROM orders
WHERE order_delivered_customer_date IS NULL
GROUP BY order_status
ORDER BY orders_cnt DESC;

SELECT order_id, order_status, order_delivered_customer_date
FROM orders
WHERE order_status = 'canceled' and order_delivered_customer_date IS NOT NULL;