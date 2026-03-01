--------------------------------------------- SOLUTION ------------------------------------------
-- Find the longest calls for each call type, then convert
WITH top3_outgoing_incoming_calls AS (
    (SELECT 
        contact_id, 
        type,
        duration 
    FROM Calls 
    WHERE type = 'outgoing' 
    ORDER BY duration DESC 
    LIMIT 3)

        UNION ALL

    (SELECT 
        contact_id, 
        type, 
        duration 
    FROM Calls 
    WHERE type = 'incoming' 
    ORDER BY duration DESC 
    LIMIT 3))

SELECT
    c.first_name,
    t.type,
    TO_CHAR(MAKE_INTERVAL(secs => duration), 'HH24:MI:SS') AS "duration_formatted"
FROM top3_outgoing_incoming_calls t
JOIN contacts c ON c.id = t.contact_id
ORDER BY type DESC, duration DESC, first_name DESC
---------------------------------------------- NOTES --------------------------------------------
--> find 3 longest incoming and outgoing calls
--> order by type, duration, and first_name DESC
--> duration must be formatted as HH:MM:SS
-------------------------------------------------------------------------------------------------
