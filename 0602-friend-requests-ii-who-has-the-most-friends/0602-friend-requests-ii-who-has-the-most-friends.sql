WITH friends_list AS (
    SELECT requester_id AS "user_id", accepter_id AS "friend_id" FROM requestaccepted
        UNION ALL
    SELECT accepter_id AS "user_id", requester_id AS "friend_id" FROM requestaccepted)

SELECT
    user_id AS "id",
    COUNT(*) AS "num"
FROM friends_list
GROUP BY user_id
ORDER BY num DESC
LIMIT 1