--------------------------------------------- SOLUTION ------------------------------------------
WITH championships_winners AS (
    SELECT wimbledon "winner" FROM Championships
        UNION ALL
    SELECT Fr_open "winner" FROM Championships
        UNION ALL
    SELECT US_open "winner" FROM Championships
        UNION ALL
    SELECT AU_open "winner" FROM Championships)

SELECT
    p.player_id,
    p.player_name,
    COUNT(winner) AS "grand_slams_count"
FROM
    players p
INNER JOIN
    championships_winners c
    ON c.winner = p.player_id
GROUP BY 1, 2
---------------------------------------------- NOTES --------------------------------------------
--> report the # of grand slam tournaments won by each player
-------------------------------------------------------------------------------------------------