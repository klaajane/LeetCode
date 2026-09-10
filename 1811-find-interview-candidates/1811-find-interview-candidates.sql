--> GOAL:
    --> find name and mail of interview candidates using the following conditions:
        --> won 3 medals in 3 consecutive contests
        --> won a gold medal

--> pseucode:
    --> data prep:

    WITH contests_reshaped AS (
    SELECT contest_id, gold_medal AS winner_id, 'gold' AS medal_type FROM contests
        UNION ALL
    SELECT contest_id, silver_medal AS winner_id, 'silver' AS medal_type FROM contests
        UNION ALL
    SELECT contest_id, bronze_medal AS winner_id, 'bronze' AS medal_type FROM contests
    )

    --> 1/ find users who won medals in 3 consecutive contests
,

winners_gap_and_island AS (
    SELECT
        winner_id,
        contest_id,
        contest_id
        -
        ROW_NUMBER() OVER (PARTITION BY winner_id ORDER BY contest_id)
        AS island_id
    FROM contests_reshaped
)
,

consecutive_wins_condition AS (
    SELECT DISTINCT
        winner_id
    FROM winners_gap_and_island
    GROUP BY winner_id, island_id
    HAVING COUNT(island_id) >= 3
)

    --> 2/ won the gold medal in 3 or more different contests
,

gold_medal_condition AS (
    SELECT winner_id
    FROM contests_reshaped
    WHERE medal_type = 'gold'
    GROUP BY winner_id
    HAVING COUNT(*) >= 3
)
,

qualified_winners AS (
    SELECT winner_id FROM consecutive_wins_condition
    UNION 
    SELECT winner_id FROM gold_medal_condition
)

SELECT
    u.name,
    u.mail
FROM qualified_winners q
INNER JOIN users u
    ON q.winner_id = u.user_id