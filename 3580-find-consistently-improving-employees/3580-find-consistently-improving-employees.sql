-------------------------------------------- SOLUTION -------------------------------------------
WITH ordered_ratings AS (SELECT
                            employee_id,
                            rating,
                            COALESCE(LEAD(rating, 2) OVER (PARTITION BY employee_id 
                                                            ORDER BY review_date ASC)
                                    ,rating) AS third_score,
                            LAG(rating, 1) OVER (PARTITION BY employee_id 
                                                 ORDER BY review_date ASC) AS second_score,
                            LAG(rating, 2) OVER (PARTITION BY employee_id 
                                                 ORDER BY review_date ASC) AS first_score,
                            ROW_NUMBER() OVER (PARTITION BY employee_id 
                                               ORDER BY review_date DESC) AS r_num
                        FROM
                            performance_reviews)
SELECT
    o.employee_id,
    e.name,
    o.third_score - o.first_score AS improvement_score
FROM
    ordered_ratings o
INNER JOIN
    employees e
    ON
    e.employee_id = o.employee_id
WHERE
    o.third_score IS NOT NULL
    AND 
    o.r_num = 1 
    AND
    o.first_score < O.second_score
    AND
    o.second_score < O.third_score
    AND
    o.first_score < O.third_score
ORDER BY
    improvement_score DESC,
    name ASC
---------------------------------------------- NOTES --------------------------------------------
--> employees who improved their performance over their last 3 reviews
--> at least 3 reviews to be considered
--> the reviews must show stricly increasing ratings
--? improvement score = diff between latest rating and earliest rating
--> Order by improvement score DESC, name ASC
-------------------------------------------------------------------------------------------------