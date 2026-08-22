-- GOAL:
    --> find loyal customers:
        --> made at least 3 purchase transactions
        --> active for at least 30 days
        --> refund rate is less than 20%

-- STEP 1: include qualified customers, add a column to flag refund transaction

WITH customer_transactions_flagged AS (
    SELECT
        customer_id,
        transaction_date,
        transaction_type,
        CASE WHEN transaction_type = 'refund' THEN 1 ELSE 0 END AS is_refund
    FROM customer_transactions
    WHERE customer_id IN (
        SELECT customer_id
        FROM customer_transactions
        GROUP BY customer_id
        HAVING COUNT(*) >= 3
    )
)
,

-- STEP 2: -- find customers who have been active for at least 30 days
           -- calculate the refund rate

loyal_customers_metrics AS (
    SELECT
        customer_id,
        MAX(transaction_date) - MIN(transaction_date) AS number_of_days,
        AVG(is_refund) * 100 AS refund_rate
    FROM customer_transactions_flagged
    GROUP BY customer_id
    )

-- STEP 4: return customers who have a refund rate less than 20%

SELECT
    customer_id
FROM loyal_customers_metrics
WHERE number_of_days >= 30 AND refund_rate < 20
ORDER BY customer_id ASC