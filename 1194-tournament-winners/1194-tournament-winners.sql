-------------------------------------------- SOLUTION -------------------------------------------
WITH matches_pivoted AS (
    SELECT player_id, SUM(score) AS "score" FROM
    (SELECT first_player AS "player_id", first_score AS "score" FROM matches
        UNION ALL
    SELECT second_player AS "player_id", second_score AS "score" FROM matches)
    GROUP BY 1),

players_ranking AS (SELECT
                        p.group_id,
                        m.*,
                        DENSE_RANK() OVER (PARTITION BY p.group_id
                                            ORDER BY m.score DESC, m.player_id ASC) as player_rnk
                    FROM
                        matches_pivoted m
                    INNER JOIN
                        players p ON p.player_id = m.player_id
                    ORDER BY group_id)

SELECT
    group_id,
    player_id
FROM
    players_ranking
WHERE
    player_rnk = 1
---------------------------------------------- NOTES --------------------------------------------
--> report winner in each grp with highest total points (tie => lowest player_id)
-------------------------------------------------------------------------------------------------