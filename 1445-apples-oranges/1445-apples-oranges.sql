--------------------------------------------- SOLUTION ------------------------------------------
SELECT sale_date, 
    SUM((SELECT sold_num WHERE fruit = 'apples')) - 
    SUM((SELECT sold_num WHERE fruit = 'oranges')) AS diff
FROM Sales
GROUP BY sale_date
ORDER BY sales_date
---------------------------------------------- NOTES --------------------------------------------
--> report the difference between the # of apples and oranges sold each day
--> order by sale_date
-------------------------------------------------------------------------------------------------