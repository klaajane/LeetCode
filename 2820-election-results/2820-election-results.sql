--------------------------------------------- SOLUTION ------------------------------------------
-- find the value of each vote:
WITH vote_worth AS (
    SELECT
        voter,
        1.0 / COUNT(*) AS vote_value
    FROM
        votes
    GROUP BY 1
),

candidate_votes AS (
    SELECT
        v.candidate,
        SUM(w.vote_value) AS vote_value
    FROM
        votes v
        INNER JOIN
            vote_worth w
            ON v.voter = w.voter
    WHERE
        v.candidate IS NOT NULL
    GROUP BY
        v.candidate
)

SELECT candidate
FROM candidate_votes
WHERE vote_value = (SELECT MAX(vote_value) FROM candidate_votes)
ORDER BY candidate
---------------------------------------------- NOTES --------------------------------------------
--> 
-------------------------------------------------------------------------------------------------