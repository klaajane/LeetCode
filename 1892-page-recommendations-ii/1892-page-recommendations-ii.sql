-------------------------------------------- SOLUTION -------------------------------------------
WITH all_friends AS (
SELECT user1_id "user_id", user2_id "friend_id" FROM friendship
    UNION
SELECT user2_id "user_id", user1_id "friend_id" FROM friendship)

SELECT
    f.user_id, l.page_id, COUNT(DISTINCT f.friend_id) AS "friends_likes"
FROM
    all_friends f
INNER JOIN
    likes AS l
    ON f.friend_id = l.user_id
    
--Filter out pages that are already liked by the user
LEFT JOIN
    likes AS l2
    ON f.user_id = l2.user_id
    AND l.page_id = l2.page_id

WHERE l2.page_id IS NULL
GROUP BY 1, 2
---------------------------------------------- NOTES --------------------------------------------
--> recommend a page to user_id: liked by one friend of user_id and is not liked by user_id
--> 
-------------------------------------------------------------------------------------------------