-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    account_id,
    day,
    SUM(CASE
            WHEN type = 'Deposit' THEN amount
            ELSE -amount
        END ) OVER (PARTITION BY account_id ORDER BY day ASC) AS "balance"
FROM
    Transactions
---------------------------------------------- NOTES --------------------------------------------
--> assume initial balance before any transaction is 0
--> balance will never be below 0
-------------------------------------------------------------------------------------------------