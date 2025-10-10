-------------------------------------------- SOLUTION -------------------------------------------
WITH second_degree_user AS (SELECT followee AS follower FROM follow
                                UNION ALL
                            SELECT follower AS follower FROM follow)
SELECT
    follower,
    COUNT(*) - 1 AS num
FROM
    second_degree_user
GROUP BY 1
HAVING
    COUNT(*) - 1 != 0
ORDER BY
    follower ASC
---------------------------------------------- NOTES --------------------------------------------
--> 2nd degree follower: follow at least 1 user & is followed by at least one user
--> report 2nd degree followers, # of followers
--> order by follower DESC
-------------------------------------------------------------------------------------------------