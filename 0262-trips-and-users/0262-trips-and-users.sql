--------------------------------------------- SOLUTION ------------------------------------------
WITH banned_users AS (
    SELECT users_id, role
    FROM Users
    WHERE banned = 'Yes'
)

SELECT
    t.request_at AS "Day",
    ROUND(
        SUM(CASE 
                WHEN t.status IN ('cancelled_by_driver', 'cancelled_by_client') 
                THEN 1 
                ELSE 0 
            END)::numeric / COUNT(*),
        2
    ) AS "Cancellation Rate"
FROM
    Trips t
WHERE
    NOT EXISTS (
        SELECT 1 
        FROM banned_users bu 
        WHERE bu.users_id = t.driver_id AND bu.role = 'driver'
    )
    AND NOT EXISTS (
        SELECT 1 
        FROM banned_users bu 
        WHERE bu.users_id = t.client_id AND bu.role = 'client'
    )
    AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY
    t.request_at
ORDER BY
    t.request_at
---------------------------------------------- NOTES --------------------------------------------
--> cancellation rate = # canceled (client or driver) request from UNBANNED users / # unbanned users request
--> find cancellation rate between "2013-10-01" and "2013-10-03" with at least one trip
--> Round cancelllation rate to 2 decimal points
----------------------------------- OPTIMIZATION & ENHANCEMENT -----------------------------------
--> 
-------------------------------------------------------------------------------------------------