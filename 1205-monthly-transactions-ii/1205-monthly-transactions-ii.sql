-------------------------------------------- SOLUTION -------------------------------------------
WITH transactions_metrics AS (
    SELECT
        TO_CHAR(t.trans_date, 'YYYY-MM') AS "month",
        t.country,
        COUNT(*) FILTER (WHERE t.state = 'approved') AS "approved_count",
        SUM(CASE WHEN t.state = 'approved' THEN t.amount ELSE 0 END) AS "approved_amount",
        COUNT(c.trans_id) AS chargeback_count,
        SUM(CASE WHEN c.trans_id IS NOT NULL THEN t.amount ELSE 0 END) AS chargeback_amount
    FROM
        Transactions t
    LEFT JOIN
        Chargebacks c ON t.id = c.trans_id
    GROUP BY
        country, month

        UNION ALL
    
    SELECT
        TO_CHAR(c.trans_date, 'YYYY-MM') AS "month",
        t.country,
        0 AS "approved_count",
        0 AS "approved_amount",
        COUNT(*) AS "chargeback_count",
        SUM(t.amount) AS "chargeback_amount"
    FROM
        transactions t
    JOIN
        chargebacks c ON t.id = c.trans_id
    GROUP BY
        month, t.country)

SELECT
    month,
    country,
    SUM(approved_count) AS "approved_count",
    SUM(approved_amount) AS "approved_amount",
    SUM(chargeback_count) AS "chargeback_count",
    SUM(chargeback_amount) AS "chargeback_amount"
FROM
    transactions_metrics
GROUP BY
    month, country
ORDER BY    
    month
--HAVING
    --(SUM(approved_count) != 0  AND SUM(approved_amount) != 0 AND SUM(chargeback_count) != 0 AND SUM(chargeback_amount) != 0)
---------------------------------------------- NOTES --------------------------------------------
--> find # of approved transaction, $ amount, # of chargebacks, $ amount for each month / country
-------------------------------------------------------------------------------------------------