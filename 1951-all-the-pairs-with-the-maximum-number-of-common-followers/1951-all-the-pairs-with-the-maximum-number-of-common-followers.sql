-------------------------------------------- SOLUTION -------------------------------------------
WITH follower_count AS (
    SELECT
        r1.user_id "user1_id",
        r2.user_id "user2_id",
        COUNT(DISTINCT r1.follower_id) AS "followers_count"
    FROM
        relations r1
        INNER JOIN 
            relations r2
            ON r1.follower_id = r2.follower_id
            AND r1.user_id < r2.user_id
    GROUP BY 1, 2)

SELECT
    user1_id,
    user2_id
FROM
    follower_count
WHERE
    followers_count = (SELECT MAX(followers_count) FROM follower_count)
---------------------------------------------- NOTES --------------------------------------------
--> find all the pairs of users with maximum # of common followers
-------------------------------------------------------------------------------------------------