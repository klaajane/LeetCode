-------------------------------------------- SOLUTION -------------------------------------------
WITH views_metrics AS (SELECT
                            DISTINCT v1.viewer_id,
                            COUNT(DISTINCT v1.article_id) AS view_count,
                            v1.view_date
                        FROM
                            views v1 
                        INNER JOIN
                            views v2 ON v1.viewer_id = v2.viewer_id
                        WHERE
                            v1.article_id != v2.article_id
                        GROUP BY 1, 3)

SELECT DISTINCT viewer_id AS "id"
FROM views_metrics
WHERE view_count > 1
---------------------------------------------- NOTES --------------------------------------------
--> find people who viewed more than one article on the same date
--> order by id ASC
-------------------------------------------------------------------------------------------------