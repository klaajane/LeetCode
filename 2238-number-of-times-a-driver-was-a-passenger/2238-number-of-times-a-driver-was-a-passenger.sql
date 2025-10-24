--------------------------------------------- SOLUTION ------------------------------------------
SELECT
    r1.driver_id,
    COUNT(DISTINCT r2.ride_id) AS "cnt"
FROM
    rides r1
    LEFT JOIN
        rides r2
        ON r1.ride_id != r2.ride_id
        AND r1.driver_id = r2.passenger_id
GROUP BY 1
---------------------------------------------- NOTES --------------------------------------------
--> report the ID of each driver the # of times they were passenger
-------------------------------------------------------------------------------------------------