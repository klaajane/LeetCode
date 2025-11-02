-------------------------------------------- SOLUTION -------------------------------------------
WITH transaction_series AS (
    SELECT
        user_id,
        spend,
        transaction_date,
        ROW_NUMBER() OVER (PARTITION BY user_id
                            ORDER BY transaction_date) AS "r_id"
    FROM
        Transactions
),

qualified_users AS (
    SELECT user_id FROM transaction_series
    WHERE r_id <= 3
    GROUP BY user_id
    HAVING COUNT(*) <= 3
)

SELECT DISTINCT
    t1.user_id,
    t1.spend AS "third_transaction_spend",
    t1.transaction_date AS "third_transaction_date"
FROM
    transaction_series t1
        INNER JOIN
            transaction_series t2
                ON t1.user_id = t2.user_id AND t1.spend > t2.spend
        INNER JOIN
            transaction_series t3
                ON t1.user_id = t3.user_id AND t1.spend > t3.spend
WHERE
    t1.r_id = 3
    AND 
    t1.user_id IN (SELECT user_id FROM qualified_users)
ORDER BY 
    user_id
---------------------------------------------- NOTES --------------------------------------------
--> find 3rd transaction (if they have at least 3 transactions) where spending 3rd > 2nd & 1st
--> order by user_id ASC
-------------------------------------------------------------------------------------------------