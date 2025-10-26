--------------------------------------------- SOLUTION ------------------------------------------
WITH drinks AS (
    SELECT
        id,
        drink,
        COALESCE(LAG(drink) OVER (), drink) AS "prev_drink",
        ---ROW_NUMBER() OVER () AS "rnk",
        FIRST_VALUE(drink) OVER () AS "first_value"
    FROM
        CoffeeShop
)
    
SELECT 
    id,
    COALESCE(drink, prev_drink, first_value) AS "drink"
FROM
    drinks
---------------------------------------------- NOTES --------------------------------------------
--> replace the null values of the drink with the non-NULL name of the drink from prev row 
-------------------------------------------------------------------------------------------------