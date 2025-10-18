--------------------------------------------- SOLUTION ------------------------------------------
WITH all_ids AS(
    SELECT
        ids
    FROM
        generate_series(
                        1,
                        (SELECT MAX(customer_id) FROM customers)
        ) AS ids)

SELECT
    ids
FROM
    all_ids
WHERE
    ids NOT IN (SELECT customer_id FROM customers)
---------------------------------------------- NOTES --------------------------------------------
--> find the missing customer ID.
--> missing customer id: not in the customers table but are in the range between 1 and max customer id
-------------------------------------------------------------------------------------------------