-- Write your PostgreSQL query statement below

-- CASE STATEMENT for flagging books with polarized opinions

-- SUB QUERY to return books that have at least 5 reading books

-- 
WITH reading_sessions_polarized_check AS (
    SELECT
        book_id,
        COUNT(*) AS total_session,
        MIN(session_rating) AS minrating,
        MAX(session_rating) AS maxrating,
        sum(case when session_rating>3 then 1 else 0 end)highrating,
        sum(case when session_rating<3 then 1 else 0 end )lowrating,
        sum(case when session_rating>3 or session_rating<3 then 1 else 0 end) extremes
    FROM reading_sessions
    WHERE book_id IN (
        SELECT book_id
        FROM reading_sessions
        GROUP BY book_id
        HAVING COUNT(*) >= 5
    )
    GROUP BY book_id
)

,
polarization_score_by_book AS (
    SELECT 
        r.book_id,
        b.title,
        b.author,
        b.genre,
        b.pages,
        maxrating - minrating AS rating_spread,
        ROUND(
            extremes * 1.0
            /
            total_session
            ,2
        ) AS polarization_score
    FROM reading_sessions_polarized_check r
    JOIN books b
        ON b.book_id = r.book_id
    WHERE
        total_session > 4
        AND
        highrating > 0
        AND
        lowrating > 0
    ORDER BY polarization_score DESC, title DESC
    )

SELECT * FROM polarization_score_by_book
WHERE polarization_score >= 0.6