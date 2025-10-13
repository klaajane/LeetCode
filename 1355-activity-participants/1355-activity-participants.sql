-------------------------------------------- SOLUTION -------------------------------------------
WITH friend_activity AS (
    SELECT
        activity,
        COUNT(*) AS "friends_count"
    FROM
        Friends
    GROUP BY 1)

SELECT
    activity
FROM    
    friend_activity
WHERE
    friends_count NOT IN (SELECT MAX(friends_count) FROM friend_activity)
    AND
    friends_count NOT IN (SELECT MIN(friends_count) FROM friend_activity)

---------------------------------------------- NOTES --------------------------------------------
--> find names of all activities with neither the max nor the min # of participants
-------------------------------------------------------------------------------------------------