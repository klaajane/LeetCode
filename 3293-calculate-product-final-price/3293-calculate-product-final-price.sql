SELECT
    p.product_id,
    COALESCE(
        (p.price * (100 - d.discount) * 1.0) 
        / 
        100.0
        ,p.price) AS "final_price",
    p.category
FROM products p
LEFT JOIN discounts d ON d.category = p.category
ORDER BY p.product_id ASC