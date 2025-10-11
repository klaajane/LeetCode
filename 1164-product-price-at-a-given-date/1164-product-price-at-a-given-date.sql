-------------------------------------------- SOLUTION -------------------------------------------
WITH qualified_products AS (SELECT
                                *,
                                ROW_NUMBER() OVER (PARTITION BY product_id
                                                    ORDER BY change_date DESC) AS rnk 
                            FROM
                                Products
                            WHERE
                                change_date <= '2019-08-16')
SELECT
    DISTINCT p.product_id,
    COALESCE(q.new_price, 10) AS price
FROM
    products p
LEFT JOIN
    qualified_products q ON q.product_id = p.product_id
                        AND rnk = 1
---------------------------------------------- NOTES --------------------------------------------
--> all products have a price of 10
--> find prices on the date 2019-08-16
-------------------------------------------------------------------------------------------------