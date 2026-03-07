WITH reaction_ratios AS (
    SELECT 
        user_id, 
        reaction,
        SUM(COUNT(*)) OVER (PARTITION BY user_id) AS "reaction_count",
        ROUND(
            COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY user_id)
            , 2) AS "reaction_ratio"
    FROM reactions
    GROUP BY user_id, reaction)

SELECT DISTINCT
    r.user_id,
    rr.reaction AS "dominant_reaction",
    rr.reaction_ratio
FROM reactions r
JOIN reaction_ratios rr ON r.user_id = rr.user_id
WHERE reaction_ratio >= 0.6
  AND reaction_count >= 5 
ORDER BY reaction_ratio DESC, user_id