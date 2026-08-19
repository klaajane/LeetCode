WITH sales_by_month_product AS (
    SELECT 
        product_id,
        EXTRACT(MONTH FROM sale_date) AS month,
        quantity,
        quantity * price AS revenue
    FROM sales
    )
,

seasonal_sales AS (
    SELECT
    product_id,
    CASE
        WHEN month IN (9, 10, 11) THEN 'Fall'
        WHEN month IN (12, 1, 2) THEN 'Winter'
        WHEN month IN (3, 4, 5) THEN 'Spring'
        WHEN month IN (6, 7, 8) THEN 'Summer'
    END AS season,
    quantity,
    revenue
FROM sales_by_month_product 
)
,

master_final AS (
    SELECT
        s.season,
        p.category,
        SUM(quantity) AS total_quantity,
        SUM(revenue) AS total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY season
            ORDER BY 
                SUM(quantity) DESC,
                SUM(revenue) DESC
        ) AS rnk
    FROM seasonal_sales s
    JOIN products p
        ON p.product_id = s.product_id
    GROUP BY s.season, p.category
    ORDER BY s.season
    )

SELECT
    season,
    category,
    total_quantity,
    total_revenue
FROM master_final
WHERE rnk = 1
ORDER BY season
