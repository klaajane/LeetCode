--------------------------------------------- SOLUTION ------------------------------------------
WITH recursive
    visit_metrics AS(
        SELECT
            v.user_id,
            v.visit_date,
            SUM(CASE
                    WHEN t.user_id IS NULL THEN 0
                    ELSE 1
                END) AS "transactions_count"
        FROM
            visits v
        LEFT JOIN
            transactions t ON t.user_id = v.user_id
                           AND t.transaction_date = v.visit_date
        GROUP BY 1, 2
)

, transaction_series AS (
    SELECT 0 AS transactions_count
        UNION ALL
    SELECT transactions_count + 1 FROM transaction_series
    WHERE transactions_count < (SELECT MAX(transactions_count) FROM visit_metrics)
)

SELECT
    t.transactions_count,
    COALESCE(COUNT(v.visit_date), 0) AS visits_count
FROM
    transaction_series t
LEFT JOIN
    visit_metrics v
    ON t.transactions_count = v.transactions_count
GROUP BY
    t.transactions_count
ORDER BY
    t.transactions_count
---------------------------------------------- NOTES --------------------------------------------
--> find # of users visited the bank with 0 transactions, # of visits with 1 transaction...
--> transaction_count: # transactions in one visit
--> visits_count: # of userrs who did the transaction_count in one visit to the bank
-------------------------------------------------------------------------------------------------