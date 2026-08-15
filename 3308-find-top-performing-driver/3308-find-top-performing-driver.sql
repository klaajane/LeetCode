---------------------------- SOLUTION --------------------------------
-- join the tables, calculate the AVG rating, rank the drivers,
-- then choose the top performing drivers 

WITH metrics_by_driver_and_fuel_type AS (
    SELECT
        v.fuel_type,
        v.driver_id,
        ROUND(AVG(rating), 2) AS rating,
        SUM(distance) AS distance,
        SUM(accidents) AS accidents
    FROM vehicles v
    INNER JOIN trips t -- all vehciles have been used
        ON v.vehicle_id = t.vehicle_id
    INNER JOIN drivers d -- all drivers have at least a vehicle
        ON d.driver_id = v.driver_id
    GROUP BY 
        v.fuel_type, 
        v.driver_id
    )
,

-- STEP 2: apply the DENSE_RANK():

ranked_drivers_by_fuel_type AS (
    SELECT
        fuel_type,
        driver_id,
        rating,
        distance,
        DENSE_RANK() OVER ( -- we need to continue the ranking sequence
            PARTITION BY fuel_type
            ORDER BY 
                rating DESC,
                distance DESC,
                accidents ASC
        ) AS rnk
    FROM metrics_by_driver_and_fuel_type
    )   

SELECT
    fuel_type,
    driver_id,
    rating,
    distance
FROM ranked_drivers_by_fuel_type
WHERE rnk = 1
ORDER BY fuel_type ASC
----------------------------- NOTES -------------------------------
--> GOAL:
    --> find the top_performing drivers for fuel type based on:
        --> AVG rating across trips (ROUND to 2)
        --> Tie ==> driver with longer distance should be first
        --> still a tie => driver with fewer accidents

--> ORDER BY:
    --> fuel_type ASC
--------------------------------------------------------------------


--> CAN DRIVERS HAVE MULTIPLE VEHICLES? IF SO, WE NEED TO GROUP BY 
--> THE RESULTS