-------------------------------------------- SOLUTION -------------------------------------------
WITH polarized_opinion AS (SELECT
                                book_id,
                                MAX(session_rating) - MIN(session_rating) AS "rating_spread",
                                ROUND(1.00 * SUM(CASE WHEN session_rating >= 4 
                                                           OR 
                                                           session_rating <= 2
                                                      THEN 1
                                                      ELSE 0
                                                END)
                                            /
                                            COUNT(*)
                                    ,2) AS "polarization_score",
                                COUNT(*) AS "reading_session_count",
                                SUM(CASE WHEN session_rating >= 4
                                        THEN 1
                                        ELSE 0
                                    END) AS "highest_extreme",
                                SUM(CASE WHEN session_rating <= 2
                                        THEN 1
                                        ELSE 0
                                    END) AS "lowest_extreme"
                            FROM    
                                reading_sessions
                            GROUP BY
                                1)
SELECT
    p.book_id,
    b.title,
    b.author,
    b.genre,
    b.pages,
    p.rating_spread,
    p.polarization_score
FROM
    polarized_opinion p
INNER JOIN
    books b
    ON
    b.book_id = p.book_id
WHERE
    p.reading_session_count >= 5
    AND
    p.polarization_score >= 0.6
    AND
    (p.highest_extreme != 0 AND p.lowest_extreme != 0)
ORDER BY
    p.polarization_score DESC,
    b.title DESC
---------------------------------------------- NOTES --------------------------------------------
--> polarized opinions: books that receive both very high/low ratings from different readers
--> only include books that have at least 5 reading sessions
--> calculate rating spread (highest_rating - lowest_rating)
--> polarization score: # of extreme ratings / total sessions
--> only include books with a polarization score >= 0.6
--> order by polarization socer DESC, title DESC
-------------------------------------------------------------------------------------------------