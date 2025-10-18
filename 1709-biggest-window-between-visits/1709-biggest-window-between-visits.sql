--------------------------------------------- SOLUTION ------------------------------------------
WITH visits_history AS (
    SELECT
        user_id,
        visit_date,
        COALESCE(
            LEAD(visit_date) OVER (PARTITION BY user_id
                                ORDER BY visit_date ASC)
            , '2021-1-1'
                ) AS "next_visit"
    FROM 
        UserVisits)

SELECT
    user_id,
    MAX(next_visit - visit_date) AS "biggest_window"
FROM
    visits_history
GROUP BY
    user_id
---------------------------------------------- NOTES --------------------------------------------
--> today is 2021-1-1
--> find the largest window of days between each visit and the following one for each user_id
-------------------------------------------------------------------------------------------------