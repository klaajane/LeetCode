--------------------------------------------- SOLUTION ------------------------------------------
WITH gold_medal_winner AS (
    SELECT
        gold_medal AS "winner_id"
    FROM
        contests
    GROUP BY 1
    HAVING COUNT(*) >= 3),

all_winners AS (
    SELECT contest_id, gold_medal "winner_id" FROM contests
        UNION ALL
    SELECT contest_id, silver_medal "winner_id" FROM contests
        UNION ALL
    SELECT contest_id, bronze_medal "winner_id" FROM contests),

contest_streak AS (
    SELECT
        contest_id,
        winner_id,
        contest_id
        -
        ROW_NUMBER() OVER (PARTITION BY winner_id ORDER BY contest_id)
        AS "grp"
    FROM
        all_winners
    ORDER BY 2, 1),

qualified_winners AS(
    SELECT DISTINCT
        winner_id
    FROM
        contest_streak
    GROUP BY 1, grp
    HAVING COUNT(*) >= 3

        UNION

    SELECT winner_id FROM gold_medal_winner)

SELECT
    u.name,
    u.mail
FROM
    users u
INNER JOIN
    qualified_winners q
    ON q.winner_id = u.user_id
---------------------------------------------- NOTES --------------------------------------------
--> report name and mail of all interview candidates
--> interview candidate: won any 3 or more medals consecutively, 
                    --   won 3 gold medal not necessarily consecutive
-------------------------------------------------------------------------------------------------