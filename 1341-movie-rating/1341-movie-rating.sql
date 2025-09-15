-------------------------------------------- SOLUTION -------------------------------------------
WITH users_movie_count AS (SELECT
                                u.name
                                ,COUNT(m.user_id) 
                            FROM 
                                MovieRating m
                            INNER JOIN
                                Users u
                                ON u.user_id = m.user_id
                            GROUP BY 
                                u.name
                            ORDER BY 
                                COUNT(m.user_id) DESC
                                ,u.name
                            LIMIT 1),

movie_avg_rating AS (SELECT
                         mr.movie_id
                        ,m.title 
                        ,AVG(mr.rating) AS avg_movie_rating
                    FROM   
                        movies m
                    INNER JOIN
                        movierating mr
                        ON mr.movie_id = m.movie_id
                    WHERE 
                        mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
                    GROUP BY 
                         mr.movie_id
                        ,m.title
                    ORDER BY 
                         avg_movie_rating DESC
                        ,m.title
                    LIMIT 1)

SELECT name AS "results" FROM users_movie_count
    UNION ALL
SELECT title AS "results" FROM movie_avg_rating
---------------------------------------------- NOTES --------------------------------------------
--> name of the user with the greatest # of movies
--> tie = return the lexicographically smaller user name
--> movie name with highest average in Februray 2020
--> tie = return the lexicographically smaller movie name
-------------------------------------------------------------------------------------------------