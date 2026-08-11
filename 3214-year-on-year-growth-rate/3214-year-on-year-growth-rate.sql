--------------------------------------------- SOLUTION ------------------------------------------
WITH spend_by_product_year AS (
    SELECT
        product_id,
        EXTRACT(YEAR FROM transaction_date) AS year,
        SUM(spend) AS spend
    FROM user_transactions 
    GROUP BY product_id, EXTRACT(YEAR FROM transaction_date)
    )
,

yoy_intermediate_calculation AS (
    SELECT
        year,
        product_id,
        spend AS curr_year_spend,
        LAG(spend) OVER (
            PARTITION BY product_id
            ORDER BY year ASC
        ) AS prev_year_spend
    FROM spend_by_product_year
    )

SELECT
    *,
    ROUND(
    (curr_year_spend - prev_year_spend) * 100.0 
        / 
    COALESCE(prev_year_spend, 0)
     ,2) AS yoy_rate
FROM yoy_intermediate_calculation
ORDER BY 
    product_id, 
    year
---------------------------------------------- NOTES --------------------------------------------
--> GOAL:
    --> calculate the YOY growth rate for the total spend for each product

--> ORDER BY:
    --> product_id ASC
    --> year ASC
-------------------------------------------------------------------------------------------------
-- PAY ATTENTION: YOU HAVE TO GROUP BY TRANSACTIONS BY DATE FIRST BECAUSE THERE WILL
-- ROWS WITH THE SAME YEAR FOR MANY RECORDS, SO THEY NEED BE GROUPED BEFORE COMPUTING THE YOY

-- PAYYYY ATTENTION TO PROBLEM!!!!!
-- How should the null for the first year be handlede