-------------------------------------------- SOLUTION -------------------------------------------
-- Find the list of all users
WITH friends_list AS (
    SELECT user_id1 AS "this_id", user_id2 AS "other_id" FROM friends f1
        UNION ALL
    SELECT user_id2 AS "this_id", user_id1 AS "other_id" FROM friends f2)

SELECT
    user_id1,
    user_id2
FROM 
    friends f
WHERE NOT EXISTS 
    (
    SELECT 1
    FROM friends_list fa
    JOIN friends_list fb
    ON fa.other_id = fb.other_id
    WHERE fa.this_id = f.user_id1
    AND fb.this_id = f.user_id2
    )
ORDER BY
    user_id1,
    user_id2
---------------------------------------------- NOTES --------------------------------------------
--> query's goal: find all pairs that are friends with each other and have no mutual friends
    --> ORDER BY:
        --> user_id1, user_id2 ASC oder 
-------------------------------------------------------------------------------------------------