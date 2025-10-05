-------------------------------------------- SOLUTION -------------------------------------------
WITH polarized_opinion AS (
    SELECT
        book_id,
        MAX(session_rating) - MIN(session_rating) AS rating_spread,
        COUNT(*) AS session_count,
        COUNT(*) FILTER (WHERE session_rating >= 4 OR session_rating <= 2) AS extreme_count,
        COUNT(*) FILTER (WHERE session_rating >= 4) AS high_extreme,
        COUNT(*) FILTER (WHERE session_rating <= 2) AS low_extreme
    FROM reading_sessions
    GROUP BY book_id
)
SELECT
    p.book_id,
    b.title,
    b.author,
    b.genre,
    b.pages,
    p.rating_spread,
    ROUND(p.extreme_count * 1.0 / p.session_count, 2) AS polarization_score
FROM
    polarized_opinion p
JOIN
    books b ON b.book_id = p.book_id
WHERE
    p.session_count >= 5
    AND p.extreme_count * 1.0 / p.session_count >= 0.6
    AND p.high_extreme > 0
    AND p.low_extreme > 0
ORDER BY
    polarization_score DESC,
    b.title DESC;

---------------------------------------------- NOTES --------------------------------------------
--> polarized opinions: books that receive both very high/low ratings from different readers
--> only include books that have at least 5 reading sessions
--> calculate rating spread (highest_rating - lowest_rating)
--> polarization score: # of extreme ratings / total sessions
--> only include books with a polarization score >= 0.6
--> order by polarization socer DESC, title DESC
-------------------------------------------------------------------------------------------------