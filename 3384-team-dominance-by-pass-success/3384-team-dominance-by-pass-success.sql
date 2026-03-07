-- Write your PostgreSQL query statement below
WITH teams_points AS (
    SELECT
        t1.team_name as "team_name",
        CASE
            WHEN p.time_stamp <= '45:00' THEN 1
            ELSE 2
        END AS "half_number",
        CASE
            WHEN t1.team_name = t2.team_name THEN 1
            ELSE -1
        END AS "points"
    FROM passes p
    JOIN teams t1 ON p.pass_from = t1.player_id
    JOIN teams t2 ON p.pass_to = t2.player_id)

--- NO NEED TO UNION THE DATA 
SELECT
    team_name,
    half_number,
    SUM(points) AS "dominance"
FROM teams_points
GROUP BY team_name, half_number
ORDER BY team_name, half_number
