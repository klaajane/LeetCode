-- plan: 
    --> join the passes table to the teams table
    --> use some CASE statement logic to derive the half num
    --> compare the teams of the players to calcualte the dominance score

WITH passes_analysis AS (
    SELECT
        t1.team_name,

        -- half_number:
        CASE WHEN time_stamp <= '45:00' THEN 1 ELSE 2 END AS half_number, -- we have to be inclusive

        -- check players' teams:
        CASE WHEN t1.team_name = t2.team_name THEN 1 ELSE -1 END AS pre_calc_dominance_score

    FROM passes p
    INNER JOIN teams t1
        ON t1.player_id = p.pass_from
    INNER JOIN teams t2
        ON t2.player_id = p.pass_to -- PAY ATTENTION TO THE ALIAS BEING USED
)

SELECT
    team_name,
    half_number,
    SUM(pre_calc_dominance_score) AS dominance
FROM passes_analysis 
GROUP BY team_name, half_number
ORDER BY team_name,half_number
