--------------------------------------------- SOLUTION ------------------------------------------
WITH ordered_sales AS (SELECT
                            *
                            ,RANK() OVER (PARTITION BY product_id ORDER BY year ASC) AS sales_order
                        FROM
                            Sales)
SELECT
     product_id
    ,year AS first_year
    ,quantity
    ,price
FROM
    ordered_sales
WHERE
    sales_order = 1
---------------------------------------------- NOTES --------------------------------------------
--> find FIRST YEAR sales for each product
--> returns all sales entries for those products in that year
-------------------------------------------------------------------------------------------------