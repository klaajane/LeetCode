WITH team_points AS (
    SELECT
        team_name,
        SUM(wins * 3 + draws) AS "total_points"
    FROM TeamStats
    GROUP BY team_name),

team_ranking AS (
    SELECT
        team_name,
        total_points,
        RANK() OVER (ORDER BY total_points DESC) AS "position",
        COUNT(*) OVER () as total_teams
    FROM team_points)

SELECT
    team_name,
    total_points AS "points",
    position,
    CASE
        WHEN position <= CEIL(total_teams / 3.0) THEN 'Tier 1'
        WHEN position <= CEIL(2 * total_teams / 3.0) THEN 'Tier 2'
        ELSE 'Tier 3'
    END AS "Tier"
FROM team_ranking
ORDER BY total_points DESC, team_name ASC