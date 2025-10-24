--------------------------------------------- SOLUTION ------------------------------------------
WITH next_purchases AS (  
    SELECT
        purchase_id,
        user_id,
        purchase_date,
        LEAD(purchase_date) OVER (PARTITION BY user_id
                                    ORDER BY purchase_date ASC) AS "next_purchases_date"
    FROM
        purchases p1
    WHERE EXISTS (SELECT 1 FROM purchases p GROUP BY p.user_id HAVING COUNT(*) >= 2 AND p.user_id = p1.user_id)
),

difference_in_dates AS (
    SELECT
        purchase_id,
        user_id,
        next_purchases_date - purchase_date "days_diff"
    FROM
        next_purchases
    WHERE
        next_purchases_date IS NOT NULL
)

SELECT DISTINCT user_id FROM difference_in_dates
WHERE days_diff <= 7
---------------------------------------------- NOTES --------------------------------------------
--> report IDs of the users with more than two purchaes <= 7
--> order by user_id
-------------------------------------------------------------------------------------------------