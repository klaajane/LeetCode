-------------------------------------------- SOLUTION -------------------------------------------
WITH all_friends AS
    (SELECT user1_id, user2_id FROM friendship
        UNION ALL
    SELECT user2_id, user1_id FROM friendship
),
common_friends AS (
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
    GROUP BY 1, 2
    HAVING COUNT(DISTINCT a1.user2_id) >= 3
)

SELECT
    cf.user1_id,
    cf.user2_id,
    cf.common_friend
FROM
    common_friends cf
    JOIN    
        all_friends f
        ON cf.user1_id = f.user1_id
        AND cf.user2_id = f.user2_id
ORDER BY 1, 2
---------------------------------------------- NOTES --------------------------------------------
--> strong friendships: x and y have at least 3 common friends
--> user1_id < user2_id to avoid duplicates
-------------------------------------------------------------------------------------------------