--------------------------------------------- SOLUTION ------------------------------------------
WITH yearly_spend AS (
    SELECT
        product_id,
        EXTRACT(YEAR FROM transaction_date) AS year,
        SUM(spend) AS curr_year_spend
    FROM user_transactions
    GROUP BY 
        product_id,
        EXTRACT(YEAR FROM transaction_date)
),

transactions_by_year AS (
    SELECT
        product_id,
        year,
        curr_year_spend,
        LAG(curr_year_spend) OVER (
            PARTITION BY product_id 
            ORDER BY year ASC
        ) AS prev_year_spend
    FROM yearly_spend
)

SELECT
    year,
    product_id,
    curr_year_spend,
    prev_year_spend,
    ROUND(
        (curr_year_spend - prev_year_spend) * 100.0 
        / NULLIF(prev_year_spend, 0), 
        2
    ) AS yoy_rate
FROM transactions_by_year
ORDER BY product_id, year;
---------------------------------------------- NOTES --------------------------------------------
--> find yoy growth for the total spend of each product
-------------------------------------------------------------------------------------------------
-- PAY ATTENTION: YOU HAVE TO GROUP BY TRANSACTIONS BY DATE FIRST BECAUSE THERE WILL
-- ROWS WITH THE SAME YEAR FOR MANY RECORDS, SO THEY NEED BE GROUPED BEFORE COMPUTING THE YOY