-------------------------------------------- SOLUTION -------------------------------------------
WITH user_1_friends AS(
    SELECT user1_id AS "user_id" FROM friendship WHERE user2_id = 1
        UNION
    SELECT user2_id AS "user_id" FROM friendship WHERE user1_id = 1)

SELECT DISTINCT
    page_id AS recommended_page
FROM
    likes
WHERE
    user_id IN (SELECT user_id FROM user_1_friends)    
    AND
    page_id NOT IN (SELECT page_id FROM likes WHERE user_id = 1)
ORDER BY
    page_id ASC
---------------------------------------------- NOTES --------------------------------------------
--> recommend pages to the user_id = 1, using pages that your friends liked
--> it should NOT recommend pages you already liked
--> NO duplicates
-------------------------------------------------------------------------------------------------