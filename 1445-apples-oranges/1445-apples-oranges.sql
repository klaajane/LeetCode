--------------------------------------------- SOLUTION ------------------------------------------
SELECT
    sale_date,
    SUM(CASE WHEN fruit = 'apples' THEN sold_num END)
    -
    SUM(CASE WHEN fruit = 'oranges' THEN sold_num END)
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