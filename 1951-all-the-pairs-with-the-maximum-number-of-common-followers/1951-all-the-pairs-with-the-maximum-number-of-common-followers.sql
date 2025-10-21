-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    r1.user_id "user1_id",
    r2.user_id "user2_id"
FROM
    relations r1
    INNER JOIN 
        relations r2
        ON r1.follower_id = r2.follower_id
        AND r1.user_id < r2.user_id
GROUP BY 1, 2
HAVING COUNT(DISTINCT r1.follower_id) >= 3
---------------------------------------------- NOTES --------------------------------------------
--> strong friendships: x and y have at least 3 common friends
--> user1_id < user2_id to avoid duplicates
-------------------------------------------------------------------------------------------------