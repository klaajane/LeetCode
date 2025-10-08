-------------------------------------------- SOLUTION -------------------------------------------
SELECT 
    c.name
FROM
    Candidate c
LEFT JOIN
    Vote v ON v.candidateId = c.id
GROUP BY 1
ORDER BY 
    COUNT(*) DESC
LIMIT 1
---------------------------------------------- NOTES --------------------------------------------
--> the name of the winning candidate (largest votes)
-------------------------------------------------------------------------------------------------