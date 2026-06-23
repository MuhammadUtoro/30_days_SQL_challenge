-- Day 3 of 30 of SQL Challenge

-- 1. Priya wants a single-row summary to kick off the report. Write a query that shows: the total number of transactions, the total revenue across all transactions, the average transaction value (rounded to 2 decimal places), and the smallest and largest single transaction.
SELECT COUNT(transaction_id) AS transaction_count, SUM(amount) AS total_revenue, ROUND(AVG(amount),2) AS average_amount, MIN(amount) AS min_transaction, MAX(amount) AS max_transaction FROM client_transactions;


-- 2. Priya asks: "How many unique clients and unique sales reps are in the data?" Write a single query that returns both counts.
SELECT COUNT(DISTINCT client_name) AS total_client, COUNT(DISTINCT sales_rep) AS total_sales_rep FROM client_transactions;

-- 3. Priya needs a department-level revenue breakdown. Write a query that shows each department, the number of transactions in it, and the total revenue for that department. Sort by total revenue descending so the highest-earning department appears first.
SELECT department, COUNT(transaction_id) AS total_transaction, SUM(amount) AS total_revenue FROM client_transactions GROUP BY department ORDER BY total_revenue DESC;

-- 4. Priya now wants to see how each sales rep is performing. Write a query that shows each sales rep, their department, the number of transactions they handled, and their total revenue. Filter to show only sales reps whose total revenue exceeds $300,000. Sort by total revenue descending
SELECT sales_rep, department, COUNT(transaction_id) AS total_transaction, SUM(amount) AS total_revenue FROM client_transactions GROUP BY sales_rep, department HAVING SUM(amount) > 300000 ORDER BY total_revenue DESC;
-- If the WHERE comes before GROUP BY, but in this case we filter after
-- aggregation therefore HAVING is used

-- 5. Priya wants to flag any departments where cash transactions account for more than $75,000 in total. Write a query that shows the department, the total cash revenue (where payment_method = 'Cash'), and the number of cash transactions - but only for departments that exceed the $75,000 threshold.
SELECT department, COUNT(transaction_id), SUM(amount) AS total_cash_revenue FROM client_transactions WHERE payment_method = 'Cash' GROUP BY department HAVING SUM(amount) > 75000 ORDER BY total_cash_revenue DESC;
