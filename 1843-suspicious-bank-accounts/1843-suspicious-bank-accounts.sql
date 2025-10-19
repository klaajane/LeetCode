-------------------------------------------- SOLUTION -------------------------------------------
WITH creditor_transactions_by_month AS(
    SELECT
        account_id,
        type,
        amount,
        TO_CHAR(day, 'YYYY-MM') AS date
    FROM
        transactions
    WHERE type = 'Creditor'
    ORDER BY date),

total_income AS (
SELECT  
    account_id,
    TO_DATE(date || '-01', 'YYYY-MM-DD') AS "date",
    SUM(amount) AS "amount"
FROM creditor_transactions_by_month
GROUP BY account_id, date),

suspicious_transactions AS (
    SELECT
        i.account_id,
        i.date,
        i.amount,
        a.max_income,
        --(EXTRACT(YEAR FROM i.date) * 12 + EXTRACT(YEAR FROM i.date)),
        ---DENSE_RANK() OVER (PARTITION BY i.account_id ORDER BY i.amount DESC),
        (EXTRACT(YEAR FROM i.date) * 12 + EXTRACT(MONTH FROM i.date))
        -
        DENSE_RANK() OVER (PARTITION BY i.account_id ORDER BY i.date ASC) AS "grp"
    FROM
        total_income i
    INNER JOIN
        accounts a
        ON a.account_id = i.account_id
    WHERE
        amount > max_income)
    
SELECT DISTINCT account_id
FROM suspicious_transactions
GROUP BY account_id, grp
HAVING COUNT(*) >= 2
---------------------------------------------- NOTES --------------------------------------------
--> suspicious bank account: total income > max_income for the acc for 2 or more monthes
--> total income: sum of all deposits in that month (transaction type 'Creditor')
--> report suspicious accounts IDs
-------------------------------------------------------------------------------------------------