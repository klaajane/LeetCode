--------------------------------------------- SOLUTION ------------------------------------------
WITH invoice_ranked AS (
    SELECT
        pu.invoice_id,
        SUM(pr.price * pu.quantity) AS "total_price",
        DENSE_RANK() OVER (ORDER BY SUM(pr.price * pu.quantity) DESC, pu.invoice_id ASC) AS "price_rnk"
    FROM
        purchases pu
        INNER JOIN
            products pr
            ON pr.product_id = pu.product_id
    GROUP BY 1)

SELECT 
    pu.product_id,
    pu.quantity,
    (pu.quantity * pr.price) AS "price"
FROM
    purchases pu
    INNER JOIN  
        products pr
        ON pu.product_id = pr.product_id
WHERE pu.invoice_id IN (SELECT invoice_id 
                        FROM invoice_ranked 
                        WHERE price_rnk = 1)
---------------------------------------------- NOTES --------------------------------------------
--> show details of the invoice with the highest price 
--> two or more invoice have the same price => return the details of smallest invoice_id
-------------------------------------------------------------------------------------------------