-------------------------------------------- SOLUTION -------------------------------------------
-- Find the list of all users
WITH friends_list AS (
    SELECT user_id1 AS "this_id", user_id2 AS "other_id" FROM friends f1
        UNION ALL
    SELECT user_id2 AS "this_id", user_id1 AS "other_id" FROM friends f2)
,

mutual_friends_finder AS (
    SELECT
        f.user_id1 AS personA,
        f.user_id2 AS personB,
        fa.other_id AS Afrnd,
        fb.other_id AS Bfrnd
    FROM friends f
    JOIN friends_list fa ON f.user_id1 = fa.this_id
    JOIN friends_list fb ON f.user_id2 =  fb.this_id)

SELECT
    personA AS user_id1,
    personB AS user_id2
FROM mutual_friends_finder
GROUP BY personA, personB
HAVING SUM((Afrnd = Bfrnd)::int) = 0
ORDER BY user_id1, user_id2
---------------------------------------------- NOTES --------------------------------------------
--> find all pairs of users who are friends with each other and have no mutual friends
--> order by user_id1, user_id2 ASC
-------------------------------------------------------------------------------------------------