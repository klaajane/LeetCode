--------------------------------------------- SOLUTION ------------------------------------------
WITH users_amount AS (
    SELECT paid_by "user_id", -amount "amount" FROM transactions
        UNION ALL
    SELECT paid_to "user_id", amount FROM transactions
        UNION ALL
    SELECT user_id, credit "amount" FROM Users),

net_credit AS (
    SELECT
        user_id,
        SUM(amount) "credit"
    FROM
        users_amount
    GROUP BY 1)

SELECT
    n.user_id,
    u.user_name "user_name",
    n.credit,
    CASE
        WHEN n.credit > 0 THEN 'No'
        ELSE 'Yes'
    END AS "credit_limit_breached"
FROM
    net_credit n
INNER JOIN
    users u
    ON u.user_id = n.user_id
ORDER BY
    n.user_id
---------------------------------------------- NOTES --------------------------------------------
--> report user_id, user_name, credit, credit_limit_breached
--> find out the current balance, check whether they have breached their credit limit (credit < 0)
-------------------------------------------------------------------------------------------------