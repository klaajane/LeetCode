-------------------------------------------- SOLUTION -------------------------------------------
WITH recs AS (
    SELECT
        l1.user_id "user1_id",
        l2.user_id "user2_id"
    FROM 
        listens l1, listens l2
    WHERE
        l1.day = l2.day
        AND l1.song_id = l2.song_id
        AND l1.user_id < l2.user_id
        AND (l1.user_id, l2.user_id) NOT IN (SELECT * FROM friendship)
        AND (l2.user_id, l1.user_id) NOT IN (SELECT * FROM friendship)
    GROUP BY 1, 2, l1.day
    HAVING COUNT(DISTINCT l1.song_id) >= 3)

SELECT user1_id AS user_id,
       user2_id AS recommended_id
FROM recs
    UNION
SELECT user2_id AS user_id,
       user1_id AS recommended_id
FROM recs
---------------------------------------------- NOTES --------------------------------------------
--> recommend friends to leetcodify users
--> x and y are not friends
--> x and y listened to the same 3 or more different songs on the same day
-------------------------------------------------------------------------------------------------