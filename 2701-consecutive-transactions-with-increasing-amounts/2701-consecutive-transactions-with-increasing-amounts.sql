-------------------------------------------- SOLUTION -------------------------------------------
-- previous date, amount for each date,amount
WITH transactions_journal AS (
    SELECT
        transaction_id,
        customer_id,
        transaction_date,
        LAG(transaction_date) OVER (PARTITION BY customer_id
                                    ORDER BY transaction_date) AS "prev_date",
        amount,
        LAG(amount) OVER (PARTITION BY customer_id
                            ORDER BY transaction_date) AS "prev_amount"
    FROM
        Transactions
    ORDER BY
        customer_id, transaction_date
),

consecutive_date_amount AS (
    SELECT
        transaction_id,
        customer_id,
        prev_date,
        transaction_date,
        prev_amount,
        amount,
        (transaction_date - DATE '0001-01-01')
        - 
        RANK() OVER (PARTITION BY customer_id ORDER BY transaction_date) AS "grp_id"
    FROM transactions_journal
    WHERE transaction_date = prev_date + INTERVAL '1 Day' 
    AND amount > prev_amount 
)

SELECT
    customer_id,
    MIN(prev_date) AS consecutive_start,
    MAX(transaction_date) AS consecutive_end
FROM
    consecutive_date_amount
GROUP BY
    customer_id, grp_id
HAVING
    COUNT(grp_id) >= 2
---------------------------------------------- NOTES --------------------------------------------
--> gap and island problem
--> report customers who have made consecutive transactions with increasing amount for at least
    -- 3 days 
--> report customer_id, consecutive_start and _end (Order ASC)
-------------------------------------------------------------------------------------------------