-------------------------------------------- SOLUTION -------------------------------------------
WITH transactions_ranked_by_amount AS (
    SELECT
        transaction_id,
        day,
        amount,
        RANK() OVER (PARTITION BY DATE(day) ORDER BY amount DESC) AS "transaction_rnk"
    FROM
        transactions)

SELECT transaction_id
FROM transactions_ranked_by_amount
WHERE transaction_rnk = 1
ORDER BY 1 ASC
---------------------------------------------- NOTES --------------------------------------------
--> report transaction IDs with max amount.
--> multiple transactions  => return them all
--> order by transaction_id ASC
-------------------------------------------------------------------------------------------------