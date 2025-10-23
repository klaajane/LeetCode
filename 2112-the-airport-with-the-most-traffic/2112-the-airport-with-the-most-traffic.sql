-------------------------------------------- SOLUTION -------------------------------------------
WITH all_airports AS (
    SELECT departure_airport "airport_id", flights_count FROM flights  
        UNION ALL
    SELECT arrival_airport "airport_id", flights_count FROM flights
),

total_flights_by_airport AS (
    SELECT
        airport_id,
        SUM(flights_count) "total_flights",
        DENSE_RANK() OVER (ORDER BY SUM(flights_count) DESC) "rnk"
    FROM 
        all_airports
    GROUP BY 1
)

SELECT airport_id 
FROM total_flights_by_airport 
WHERE rnk = 1
---------------------------------------------- NOTES --------------------------------------------
--> report ID of airport with largest # of flights that either:
    --> departed from or arrrived at the airport
--> same most traffic # => report all airports
-------------------------------------------------------------------------------------------------