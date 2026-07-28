-------------------------------------------- SOLUTION -------------------------------------------
WITH RECURSIVE first_pizza_topping AS (
    -- BASE QUERY:

    SELECT 
        topping_name::TEXT AS "pizza", 
        cost::NUMERIC AS "total_cost", 
        1 AS "topping_count", 
        topping_name AS "last_topping" 
    FROM toppings

    -- RECURSION:
    UNION ALL

    SELECT 
        f.pizza || ',' || t.topping_name AS "pizza",
        ROUND(f.total_cost + t.cost, 2) AS "total_cost",
        f.topping_count + 1 AS "topping_count",
        t.topping_name AS "last_topping"
    FROM first_pizza_topping f
    JOIN toppings t ON f.last_topping < t.topping_name
    WHERE topping_count <= 3
    ---ORDER BY total_cost DESC, pizza ASC -- cant use order by in a RECUSIVE QUERY!!!
)

SELECT pizza, total_cost FROM first_pizza_topping
WHERE topping_count = 3
ORDER BY total_cost DESC, pizza ASC
---------------------------------------------- NOTES --------------------------------------------
--> Compute total cost of all possible 3-topping pizza combos
--> Round to 2 decimal places
--> unique combo / toppings must be listed in alphabetical order
-------------------------------------------------------------------------------------------------