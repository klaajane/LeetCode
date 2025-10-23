-------------------------------------------- SOLUTION -------------------------------------------
WITH matches_oredered AS (
    SELECT
        player_id,
        match_day,
        result,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY match_day) "r"
    FROM
        Matches
),

matches_groups AS (
    SELECT
        player_id,
        match_day,
        result,
        r - ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY match_day) "group_id"
    FROM
        matches_oredered
    WHERE result = 'Win')

SELECT
    m.player_id,
    COALESCE(MAX(mg.cnt), 0) AS "longest_streak"
FROM
    (SELECT DISTINCT player_id FROM Matches ) m
    LEFT JOIN
        (SELECT player_id, group_id, COUNT(*) "cnt" FROM matches_groups GROUP BY 1, 2) mg 
        ON mg.player_id = m.player_id
GROUP BY 1
---------------------------------------------- NOTES --------------------------------------------
--> winning streak: no draws or losses in between
--> count the longest winning streak for each player
-------------------------------------------------------------------------------------------------