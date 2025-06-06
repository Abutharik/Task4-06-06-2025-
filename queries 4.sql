
-- 1. Basic SELECT with WHERE and ORDER BY
SELECT * FROM Orders
WHERE order_amount > 1000
ORDER BY order_date DESC;

-- 2. INNER JOIN to combine Customers & Orders
SELECT c.customer_name, o.order_id, o.order_date, o.order_amount
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

-- 3. LEFT JOIN to find customers with or without orders
SELECT c.customer_name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- 4. RIGHT JOIN to find orders with or without matching customers
SELECT c.customer_name, o.order_id
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

-- 5. Aggregate: total revenue
SELECT SUM(order_amount) AS total_revenue FROM Orders;

-- 6. Aggregate: average order value
SELECT AVG(order_amount) AS avg_order_value FROM Orders;

-- 7. Subquery: customers who placed orders worth more than avg
SELECT customer_id, customer_name
FROM Customers
WHERE customer_id IN (
  SELECT customer_id FROM Orders
  GROUP BY customer_id
  HAVING SUM(order_amount) > (
    SELECT AVG(order_amount) FROM Orders
  )
);

-- 8. View: customer order summary
CREATE VIEW Customer_Order_Summary AS
SELECT c.customer_name, COUNT(o.order_id) AS total_orders, SUM(o.order_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- 9. Query from the view
SELECT * FROM Customer_Order_Summary;

-- 10. Optimization: add index
CREATE INDEX idx_order_customer ON Orders(customer_id);
