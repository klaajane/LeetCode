-------------------------------------------- SOLUTION -------------------------------------------
WITH weekly_purchases AS (
    SELECT
        user_id,
        EXTRACT(WEEK FROM purchase_date) 
        - 
        EXTRACT(WEEK FROM DATE_TRUNC('month', purchase_Date)) + 1 AS "weekofyear",
        --- + 1 so that the difference <> 0
        purchase_date,
        TO_CHAR(purchase_date, 'Day') AS "day_name",
        amount_spend
    FROM
        purchases
)

SELECT
    weekofyear AS "week_of_month",
    purchase_date,
    SUM(amount_spend) AS "total_amount"
FROM
    weekly_purchases
WHERE
    TRIM(day_name) = 'Friday'
GROUP BY
    1, 2
---------------------------------------------- NOTES --------------------------------------------
--> calculate the total spending by users on Fridays in Nov 2023
--> exclude weeks with no Friday purchases
-------------------------------------------------------------------------------------------------