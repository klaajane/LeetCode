--------------------------------------------- SOLUTION ------------------------------------------
WITH capacity_check AS (
    SELECT
        f.flight_id,
        f.capacity,
        p.passenger_id,
        COUNT(p.passenger_id) OVER (PARTITION BY f.flight_id
                                    ORDER BY p.passenger_id
                                    RANGE BETWEEN 2 PRECEDING
                                    AND CURRENT ROW) AS "rolling_passengers_count"
    FROM
        flights f
        LEFT JOIN
            passengers p
            ON f.flight_id = p.flight_id
)

SELECT
    flight_id,
    SUM(CASE WHEN rolling_passengers_count <= capacity AND passenger_id IS NOT NULL THEN 1 ELSE 0 END) AS "booked_cnt",
    SUM(CASE WHEN rolling_passengers_count > capacity AND passenger_id IS NOT NULL THEN 1 ELSE 0 END) AS "waitlist_cnt"
FROM
    capacity_check
GROUP BY 1
---------------------------------------------- NOTES --------------------------------------------
--> if seats are avaibale => booking's confirmed ELSE waitlisted
--> report passengers who successfully booked a flight & # of passengers waitlisted
--> order by flight_id ASC
-------------------------------------------------------------------------------------------------