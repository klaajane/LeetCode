-------------------------------------------- SOLUTION -------------------------------------------
WITH combined_periods AS (
    SELECT fail_date AS "date", 'failed' AS "status" FROM failed
        UNION 
    SELECT success_date AS "date", 'succeeded' AS "status" FROM succeeded
    ORDER BY date ASC
    ),

status_period AS (SELECT
                        ROW_NUMBER() OVER (ORDER BY date ASC)
                        -
                        DENSE_RANK() OVER (PARTITION BY status 
                                            ORDER BY date) AS grp,
                        date,
                        status
                        ---date - INTERVAL '1 day' * ROW_NUMBER() OVER (ORDER BY date ASC) AS streak
                    FROM
                        combined_periods
                    WHERE 
                        EXTRACT(YEAR FROM date) = '2019')

SELECT
    status AS "period_state",
    MIN(date) AS "start_date",
    MAX(date) AS "end_date"
FROM
    status_period
GROUP BY 
    grp, status
ORDER BY
    start_date
---------------------------------------------- NOTES --------------------------------------------
--> report the period_state for each continuous interval of days in the period (2019-1-1 to 2019-12-31)
--> 
-------------------------------------------------------------------------------------------------