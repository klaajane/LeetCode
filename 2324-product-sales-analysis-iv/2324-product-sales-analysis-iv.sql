--------------------------------------------- SOLUTION ------------------------------------------
WITH amount_spent_by_user AS (
    SELECT
        s.product_id,
        s.user_id,
        SUM(s.quantity * p.price) AS "amount_spent",
        DENSE_RANK() OVER (PARTITION BY s.user_id
                            ORDER BY SUM(s.quantity * p.price) DESC) AS "rnk"
    FROM
        sales s
        INNER JOIN
            product p
            ON p.product_id = s.product_id
    GROUP BY 1, 2)

SELECT 
    user_id,
    product_id
FROM
    amount_spent_by_user
WHERE rnk = 1 
---------------------------------------------- NOTES --------------------------------------------
--> report of each user_id the product id on which they use spent the most money on
-------------------------------------------------------------------------------------------------