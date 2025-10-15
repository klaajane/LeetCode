--------------------------------------------- SOLUTION ------------------------------------------
WITH recursive all_days AS (
    SELECT 
        s.product_id,
        s.period_start::DATE AS "sale_date",
        s.period_end::DATE,
        s.average_daily_sales
    FROM
        sales s

    UNION ALL

    SELECT
        product_id,
        (sale_date + INTERVAL '1 day')::DATE AS "sale_date",
        period_end,
        average_daily_sales
    FROM
        all_days
    WHERE
        (sale_date + INTERVAL '1 day')::DATE <= period_end
)

SELECT
    ad.product_id,
    p.product_name,
    EXTRACT(YEAR FROM ad.sale_date)::CHAR(4) as "report_year",
    SUM(ad.average_daily_sales) AS "total_amount"
FROM
    all_days ad
INNER JOIN
    product p
    ON p.product_id = ad.product_id
GROUP BY
    ad.product_id, p.product_name, EXTRACT(YEAR FROM ad.sale_date)
---------------------------------------------- NOTES --------------------------------------------
--> report $ of each item for year, product_name, product_id, report_year, and  total $
--> order by product_id and report_year
-------------------------------------------------------------------------------------------------