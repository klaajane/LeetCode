-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    book_id,
    name
FROM
    Books
WHERE
    available_from < '2019-06-23'::DATE - INTERVAL '1 month'
    AND
    book_id NOT IN 
                  (SELECT book_id
                   FROM Orders
                   WHERE dispatch_date BETWEEN '2018-6-23' AND '2019-06-23'
                   GROUP BY book_id
                   HAVING SUM(quantity) >= 10) --GROUP BY cannot reflect books with no sales
                                               --NOT IN is a workaround to include books
                                               --with sales less than 10
---------------------------------------------- NOTES --------------------------------------------
--> book sales < 10 copies within the last 365 days
--> EXCLUDING books that have been available for less than 1 month from today
--> assume TODAY is 2019-06-23
-------------------------------------------------------------------------------------------------