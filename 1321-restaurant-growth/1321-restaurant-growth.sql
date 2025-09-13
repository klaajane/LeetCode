-------------------------------------------- SOLUTION -------------------------------------------
WITH visited_dates AS (SELECT
                            visited_on
                            ,SUM(amount) AS amount
                        FROM   
                            Customer
                        GROUP BY
                            visited_on
                        ORDER BY
                            visited_on),

ranked_moving_average AS (SELECT
                                visited_on
                                --,amount
                                ,ROUND(AVG(amount) OVER (ORDER BY visited_on ASC 
                                                ROWS BETWEEN 6 PRECEDING 
                                                AND CURRENT ROW)
                                        ,2) AS average_amount
                                ,SUM(amount) OVER (ORDER BY visited_on ASC 
                                                ROWS BETWEEN 6 PRECEDING 
                                                AND CURRENT ROW) AS amount
                                ,ROW_NUMBER() OVER (ORDER BY visited_on ASC) AS rnk
                            FROM    
                                visited_dates)
SELECT
     visited_on
    ,amount
    ,average_amount
FROM
    ranked_moving_average
WHERE 
    rnk >= 7

---------------------------------------------- NOTES --------------------------------------------
--> compute moving average of customer payments in a seven days window (current + 6 days before)
--> rounded to two decimal places
--> order by visited_on ASC
-------------------------------------------------------------------------------------------------

