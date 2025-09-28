-------------------------------------------- SOLUTION -------------------------------------------
WITH product_sales_merged AS (SELECT
                                --s.product_id,
                                s.sale_date,
                                CASE
                                    WHEN EXTRACT(MONTH FROM s.sale_date) BETWEEN 3 AND 5 THEN 'Spring'
                                    WHEN EXTRACT(MONTH FROM s.sale_date) BETWEEN 6 AND 8  THEN 'Summer'
                                    WHEN EXTRACT(MONTH FROM s.sale_date) BETWEEN 9 AND 11 THEN 'Fall'
                                    ELSE 'Winter'
                                END AS "season",
                                p.category,
                                s.quantity,
                                s.price
                                --p.*
                             FROM
                                sales s
                             INNER JOIN
                                products p
                                ON
                                p.product_id = s.product_id),
main_product_sales_table AS (SELECT
                                season,
                                category,
                                SUM(quantity) AS total_quantity,
                                SUM(quantity * price) AS total_revenue
                            FROM 
                                product_sales_merged
                            GROUP BY
                                1,2),
ordered_product_sales AS (SELECT
                                *,
                                DENSE_RANK() OVER (PARTITION BY season 
                                                   ORDER BY total_quantity DESC,
                                                            total_revenue DESC) AS rnk
                            FROM
                                main_product_sales_table)
SELECT
    season,
    category,
    total_quantity,
    total_revenue
FROM
    ordered_product_sales
WHERE
    rnk = 1
---------------------------------------------- NOTES --------------------------------------------
--> find most popular product category for each season
--> Winter: December, January, February
--> Spring: March, April, May
--> Summer: June, July, August
--> Fall: September, October, November
--> Popularity: the total quantity sold in that season
--> tie => select category with highest total revenue (quanity * price)
--> order by season ASC
-------------------------------------------------------------------------------------------------