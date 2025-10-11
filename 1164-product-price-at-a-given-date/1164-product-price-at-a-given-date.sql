-------------------------------------------- SOLUTION -------------------------------------------
WITH qualified_products1 AS (SELECT
                                *,
                                ROW_NUMBER() OVER (PARTITION BY product_id
                                                    ORDER BY change_date DESC) AS rnk 
                            FROM
                                Products
                            WHERE
                                change_date <= '2019-08-16'),

qualified_products2 AS (SELECT product_id, 10 AS "price"
                        FROM products
                        WHERE product_id NOT IN (SELECT product_id FROM qualified_products1))

SELECT product_id, new_price AS "price" FROM qualified_products1 WHERE rnk = 1
    UNION
SELECT product_id, price FROM qualified_products2
---------------------------------------------- NOTES --------------------------------------------
--> all products have a price of 10
--> find prices on the date 2019-08-16
-------------------------------------------------------------------------------------------------