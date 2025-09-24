-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    transaction_date,
    SUM(CASE
        WHEN amount % 2 != 0 THEN amount ELSE 0
    END) AS "odd_sum",
    SUM(CASE
        WHEN amount % 2 = 0 THEN amount ELSE 0
    END) AS "even_sum"
FROM
    transactions
GROUP BY
    transaction_date
ORDER BY
    transaction_date ASC

---------------------------------------------- NOTES --------------------------------------------
--> sum of amounts for odd and even transactions for each day
--> display 0 if there are no odd or even transactions for a specific date
--> transaction_date in ASC
-------------------------------------------------------------------------------------------------