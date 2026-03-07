WITH PassesWithHalf AS (
    SELECT 
        p.pass_from, 
        p.pass_to, 
        t1.team_name AS from_team,
        t2.team_name AS to_team,
        CASE 
            WHEN p.time_stamp <= '45:00' THEN 1
            ELSE 2
        END AS half_number,
        CASE 
            WHEN t1.team_name = t2.team_name THEN 1
            ELSE -1
        END AS dominance
    FROM Passes p
    JOIN Teams t1 ON p.pass_from = t1.player_id
    JOIN Teams t2 ON p.pass_to = t2.player_id
)
SELECT 
    from_team AS team_name, 
    half_number, 
    SUM(dominance) AS dominance
FROM PassesWithHalf
GROUP BY from_team, half_number
ORDER BY from_team, half_number;