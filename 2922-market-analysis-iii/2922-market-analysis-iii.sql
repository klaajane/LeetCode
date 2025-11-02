-------------------------------------------- SOLUTION -------------------------------------------
-- Join the tables
WITH orders_count AS (
    SELECT
        o.seller_id,
        COUNT(DISTINCT i.item_id) AS "num_items"
        ---u.favorite_brand,
        ---o.item_id,
        ---i.item_brand
    FROM
        orders o
            INNER JOIN
                users u
                ON u.seller_id = o.seller_id
            INNER JOIN
                items i
                ON i.item_id = o.item_id
    -- excludes items they sold that's similar to their favorite brand
    WHERE (o.seller_id, i.item_brand) NOT IN (SELECT seller_id, favorite_brand FROM users)
    GROUP BY o.seller_id
    ORDER BY o.seller_id ASC
)

SELECT seller_id, num_items
FROM orders_count
---WHERE seller_id = 26
WHERE num_items = (SELECT MAX(num_items) FROM orders_count)
---------------------------------------------- NOTES --------------------------------------------
--> find top sellers who has sold the highest UNIQUE items with different brand than their favorite
--> multiple sellers with the same highest count => return all of them
--> order by seller_id ASC
-------------------------------------------------------------------------------------------------