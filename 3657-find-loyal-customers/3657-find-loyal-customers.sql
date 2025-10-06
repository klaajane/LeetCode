-------------------------------------------- SOLUTION -------------------------------------------
WITH customer_metrics AS (SELECT
                                customer_id,
                                MAX(transaction_date) - MIN(transaction_date) AS activity_duration,
                                COUNT(*) FILTER (WHERE transaction_type = 'purchase') AS purchase_transaction_count,
                                COUNT(*) FILTER (WHERE transaction_type = 'refund') AS refund_transaction_count,
                                COUNT(*) AS transaction_count
                            FROM
                                customer_transactions
                            GROUP BY
                                customer_id)
SELECT
    customer_id
FROM
    customer_metrics
WHERE
    activity_duration >= 30
    AND purchase_transaction_count >= 3
    AND (refund_transaction_count 1.0 / transaction_count) < 0.2
ORDER BY
    customer_id ASC
---------------------------------------------- NOTES --------------------------------------------
--> find loyal customers:
--> at least 3 purchases
--> been active for at least 30 days
--> refund rate < 20%
--> Order by customer_id ASC
-------------------------------------------------------------------------------------------------