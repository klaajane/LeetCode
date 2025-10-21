-------------------------------------------- SOLUTION -------------------------------------------
WITH all_friends AS
    (SELECT user1_id, user2_id FROM friendship
        UNION ALL
    SELECT user2_id, user1_id FROM friendship
)

SELECT
    a1.user1_id,
    a2.user1_id "user2_id",
    COUNT(DISTINCT a1.user2_id) AS common_friend
FROM
    all_friends a1
    JOIN
    all_friends a2
    -- retrieve only rows with common friends
    ON a1.user2_id = a2.user2_id
    -- avoid duplicates
    AND a1.user1_id < a2.user1_id
    -- user 1 and 2 need to be friends
    WHERE EXISTS (SELECT * FROM all_friends f WHERE f.user1_id = a1.user1_id AND f.user2_id = a2.user1_id)    
GROUP BY 1, 2
HAVING COUNT(DISTINCT a1.user2_id) >= 3
---------------------------------------------- NOTES --------------------------------------------
--> strong friendships: x and y have at least 3 common friends
--> user1_id < user2_id to avoid duplicates
-------------------------------------------------------------------------------------------------