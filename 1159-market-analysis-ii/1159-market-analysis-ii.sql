-------------------------------------------- SOLUTION -------------------------------------------
WITH sales_ranked AS (SELECT
                        u.user_id AS seller_id,
                        i.item_brand,
                        ---NTH_VALUE(o.item_id, 2) OVER (PARTITION BY o.seller_id
                                                    ---ORDER BY order_date ASC
                                                    --ROWS BETWEEN UNBOUNDED PRECEDING
                                                        --And UNBOUNDED FOLLOWING) AS "2nd_sale",
                        DENSE_rank() OVER (PARTITION BY o.seller_id
                                            ORDER BY order_date ASC) AS sale_rnk,
                        u.favorite_brand
                     FROM
                        users u
                     LEFT JOIN
                        orders o ON u.user_id = o.seller_id
                     LEFT JOIN
                        items i ON i.item_id = o.item_id)

SELECT
    seller_id,
    CASE
        WHEN MAX(CASE WHEN sale_rnk = 2 THEN item_brand END) = favorite_brand
            THEN 'yes'
        ELSE 'no'
    END AS "2nd_item_fav_brand"
FROM
    sales_ranked
GROUP BY    
    seller_id, favorite_brand
---------------------------------------------- NOTES --------------------------------------------
--> find for each user whether their 2nd sale is their favorite brand
--> user sold less than two items, report answer as NO
--> no more 1 sale per day
-------------------------------------------------------------------------------------------------