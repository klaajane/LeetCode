SELECT
    t1.team_name,
    CASE WHEN time_stamp <= '45:00' THEN 1 ELSE 2 END AS half_number,
    SUM(CASE WHEN t1.team_name = t2.team_name THEN 1 ELSE -1 END) AS dominance
FROM passes p
INNER JOIN teams t1 ON t1.player_id = p.pass_from
INNER JOIN teams t2 ON t2.player_id = p.pass_to
GROUP BY t1.team_name, half_number
ORDER BY t1.team_name, half_number