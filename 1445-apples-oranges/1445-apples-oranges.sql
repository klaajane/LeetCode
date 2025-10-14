--------------------------------------------- SOLUTION ------------------------------------------
SELECT
    sale_date,
    SUM(sold_num) FILTER (WHERE fruit = 'apples')
    -
    SUM(sold_num) FILTER (WHERE fruit = 'oranges')
    AS "diff"
FROM
    Sales
GROUP BY
    sale_date
ORDER BY
    sale_date
---------------------------------------------- NOTES --------------------------------------------
--> report the difference between the # of apples and oranges sold each day
--> order by sale_date
-------------------------------------------------------------------------------------------------