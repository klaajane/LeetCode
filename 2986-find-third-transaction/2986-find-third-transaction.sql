-------------------------------------------- SOLUTION -------------------------------------------
WITH transactions_history AS (
    SELECT
        user_id,
        spend,
        transaction_date,
        LAG(spend, 1) OVER (PARTITION BY user_id ORDER BY transaction_date) AS "first_previous_date",
        LAG(spend, 2) OVER (PARTITION BY user_id ORDER BY transaction_date) AS "second_previous_date",
        DENSE_RANK() OVER (PARTITION BY user_id ORDER BY transaction_date) AS "rnk"
    FROM
        transactions
)

SELECT
    user_id,
    spend AS "third_transaction_spend",
    transaction_date AS "third_transaction_date"
FROM
    transactions_history
WHERE
    rnk = 3 
    AND spend > first_previous_date 
    AND spend > second_previous_date
---------------------------------------------- NOTES --------------------------------------------
--> find 3rd transaction (if they have at least 3 transactions) where spending 3rd > 2nd & 1st
--> order by user_id ASC
-------------------------------------------------------------------------------------------------