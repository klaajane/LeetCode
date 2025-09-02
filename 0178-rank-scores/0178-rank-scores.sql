--------------------------------------------- SOLUTION ------------------------------------------
SELECT
     score
    ,DENSE_RANK() OVER (ORDER BY score DESC) as rank
FROM
     Scores
ORDER BY 1 DESC
---------------------------------------------- NOTES --------------------------------------------
-- query: rank of the scores (DESC)
-- tie = same ranking & next ranking number after a tie (DENSE_RANK())
-- order by score in DESC
-------------------------------------------------------------------------------------------------
