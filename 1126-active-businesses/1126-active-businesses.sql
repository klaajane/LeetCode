--------------------------------------------- SOLUTION ------------------------------------------
WITH event_avg AS (SELECT
                        business_id,
                        event_type,
                        occurrences,
                        AVG(occurrences) OVER (PARTITION BY event_type) AS "avg. activity",
                        CASE
                            WHEN occurrences > AVG(occurrences) OVER (PARTITION BY event_type)
                            THEN 'yes'
                            ELSE 'no'
                        END AS "avg. activity > occurences"
                    FROM
                        events
                    ORDER BY
                        business_id, event_type)
                    --GROUP BY 1)
SELECT
    business_id
FROM
    event_avg
WHERE
    "avg. activity > occurences" = 'yes'
GROUP BY 1
HAVING
    COUNT(*) > 1
---------------------------------------------- NOTES --------------------------------------------
--> avg. activity = avg occurences across all companies that have the event
--> active busines: has more than one event_type & occurences > avg activity for the event
--> retrieve all active businesses
-------------------------------------------------------------------------------------------------