--------------------------------------------- SOLUTION ------------------------------------------
WITH customer_metrics AS (
    SELECT
        customer_id,
        category,
        SUM(amount) AS total_spent,
        COUNT(transaction_id) AS "transaction_count",
        RANK() OVER (PARTITION BY customer_id 
                     ORDER BY COUNT(transaction_id) DESC, 
                            MAX(transaction_date) DESC
                    ) AS "rnk"
    FROM transactions JOIN products USING(product_id)
    GROUP BY customer_id, category)

SELECT 
    customer_id,
    ROUND(SUM(total_spent), 2) AS "total_amount",
    SUM(transaction_count) AS "transaction_count",
    COUNT(DISTINCT category) AS "unique_categories",
    ROUND(SUM(total_spent) / SUM(transaction_count), 2) AS "avg_transaction_amount",
    (
        SELECT category 
        FROM customer_metrics mt1 
        WHERE mt1.rnk = 1 
        AND mt1.customer_id = mt2.customer_id
    ) AS "top_category",
    ROUND((SUM(transaction_count) * 10) + (SUM(total_spent) / 100), 2) AS "loyalty_score"
FROM customer_metrics mt2
GROUP BY customer_id
ORDER BY loyalty_score DESC, customer_id
---------------------------------------------- NOTES --------------------------------------------
--> Find the following:
--> total amount spent
--> # of transactions
--> # of unique product categories purchased
--> avg amount spent
--> most frequently purchased product category
--> loyalty score
---------------------------------------------THOUGHTS--------------------------------------------

-------------------------------------------------------------------------------------------------