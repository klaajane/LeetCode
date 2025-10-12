-------------------------------------------- SOLUTION -------------------------------------------
WITH socres AS (SELECT
                    match_id,
                    host_team,
                    guest_team,
                    CASE
                        WHEN host_goals > guest_goals THEN 3
                        WHEN host_goals = guest_goals THEN 1
                        ELSE 0
                    END AS "hosts_points",
                    CASE
                        WHEN host_goals < guest_goals THEN 3
                        WHEN host_goals = guest_goals THEN 1
                        ELSE 0
                    END AS "guest_points"    
                FROM
                    matches)

SELECT tm.team_id, tm.team_name, COALESCE(SUM(t.num_points), 0) AS "num_points" 
FROM
    (SELECT host_team AS "team_id", hosts_points AS "num_points" FROM socres
            UNION ALL -- KEEPS THE DUPLICATES
    SELECT guest_team AS "team_id", guest_points AS "num_points" FROM socres) t
RIGHT JOIN
    teams tm ON tm.team_id = t.team_id
GROUP BY 1, 2
ORDER BY 3 DESC, 1 ASC
---------------------------------------------- NOTES --------------------------------------------
--> report, team_id, team_name, and num_points
--> A team receives three points if they win a match (i.e., Scored more goals than the opponent team).
--> A team receives one point if they draw a match (i.e., Scored the same number of goals as the opponent team).
--> A team receives no points if they lose a match (i.e., Scored fewer goals than the opponent team).
--> order by num_points in DESC, tie => team_id ASC
-------------------------------------------------------------------------------------------------