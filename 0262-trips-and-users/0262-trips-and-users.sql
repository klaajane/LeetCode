--------------------------------------------- SOLUTION ------------------------------------------
SELECT
    request_at AS "Day",
    ROUND(
        SUM(CASE 
                WHEN status IN ('cancelled_by_driver', 'cancelled_by_client') 
                THEN 1 
                ELSE 0 
            END)::numeric / COUNT(*),
        2
    ) AS "Cancellation Rate"
FROM
    Trips
WHERE
    driver_id NOT IN (
        SELECT users_id 
        FROM Users 
        WHERE banned = 'Yes' AND role = 'driver'
    )
    AND client_id NOT IN (
        SELECT users_id 
        FROM Users 
        WHERE banned = 'Yes' AND role = 'client'
    )
    AND
    request_at BETWEEN '2013-10-01' and '2013-10-03'
GROUP BY
    request_at
---------------------------------------------- NOTES --------------------------------------------
--> cancellation rate = # canceled (client or driver) request from UNBANNED users / # unbanned users request
--> find cancellation rate between "2013-10-01" and "2013-10-03" with at least one trip
--> Round cancelllation rate to 2 decimal points
----------------------------------- OPTIMIZATION & ENHANCEMENT -----------------------------------
--> 
-------------------------------------------------------------------------------------------------