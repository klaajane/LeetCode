WITH teams_performance AS (
    SELECT
        season_id,
        team_id,
        team_name,
        (3 * wins + draws) AS "points",
        (goals_for - goals_against) AS "goal_difference"
    FROM seasonstats)

SELECT
    *,
    DENSE_RANK() OVER (PARTITION BY season_id
                        ORDER BY points DESC, 
                          goal_difference DESC,
                          team_name) AS "position"
FROM teams_performance