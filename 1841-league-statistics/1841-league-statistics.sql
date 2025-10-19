-------------------------------------------- SOLUTION -------------------------------------------
WITH matches_records AS (
    SELECT home_team_id "team_id", home_team_goals "home", away_team_goals "away" FROM matches
        UNION ALL
    SELECT away_team_id "team_id", away_team_goals "home", home_team_goals "away" FROM matches)

SELECT
    team_name,
    COUNT(*) AS "matches_played",
    SUM(CASE 
            WHEN home > away THEN 3
            WHEN home = away THEN 1
            ELSE 0
        END) AS "points",
    SUM(home) AS "goal_for",
    SUM(away) AS "goal_against",
    SUM(home) - SUM(away) AS "goal_diff"
FROM
    matches_records m
INNER JOIN
    teams t
    ON t.team_id = m.team_id
GROUP BY 1
ORDER BY 3 DESC, 6 DESC, 1 ASC
---------------------------------------------- NOTES --------------------------------------------
--> win: 3 points. Loss: 0 points. draw = 1 point
-------------------------------------------------------------------------------------------------