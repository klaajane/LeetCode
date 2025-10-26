--------------------------------------------- SOLUTION ------------------------------------------
WITH drinks AS (
    SELECT
        id,
        drink,
        ROW_NUMBER() OVER () AS "r" 
    FROM
        CoffeeShop
),
    
drinks2 AS (
    SELECT 
        id,
        drink,
        r,
        SUM(CASE WHEN drink IS NULL THEN 0 ELSE 1 END) OVER (order by r) AS "grp_id"
    FROM
        drinks
)

SELECT
    id,
    first_value(drink) OVER (PARTITION BY grp_id
                             ORDER BY r) AS "drink"
FROM
    drinks2
---------------------------------------------- NOTES --------------------------------------------
--> replace the null values of the drink with the non-NULL name of the drink from prev row 
-------------------------------------------------------------------------------------------------