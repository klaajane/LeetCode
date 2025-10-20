-------------------------------------------- SOLUTION -------------------------------------------
SELECT DISTINCT
    l1.user_id AS user1_id,
    l2.user_id AS user2_id
FROM
    Listens l1, Listens l2
WHERE
    l1.song_id = l2.song_id
   AND l1.day = l2.day
   AND l1.user_id != l2.user_id
   AND (l1.user_id, l2.user_id) IN (SELECT * FROM friendship)
GROUP BY 1, 2, l2.day
HAVING COUNT(DISTINCT l1.song_id) >= 3;
---------------------------------------------- NOTES --------------------------------------------
--> report similar friends
--> similar friends: x and y are friends, listened to the same 3 or more songs on the SAME DAY
--> pairs must be returned in this order user1_id < user2_id
-------------------------------------------------------------------------------------------------