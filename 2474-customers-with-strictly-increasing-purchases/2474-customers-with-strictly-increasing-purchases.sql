WITH yearly_sales AS (
    SELECT
        customer_id,
        EXTRACT(YEAR FROM order_date) AS year,
        SUM(price) AS total_purchase
    FROM orders
    GROUP BY customer_id, EXTRACT(YEAR FROM order_date)
),

year_range AS (
    SELECT
        customer_id,
        MIN(EXTRACT(YEAR FROM order_date)) AS min_year,
        MAX(EXTRACT(YEAR FROM order_date)) AS max_year
    FROM orders
    GROUP BY customer_id
),

-- Generate all years for each customer between first and last order
expanded_years AS (
    SELECT
        r.customer_id,
        gs AS year
    FROM year_range r,
         generate_series(r.min_year, r.max_year, 1) AS gs
),

-- Merge missing years with 0 purchase
filled_sales AS (
    SELECT
        e.customer_id,
        e.year,
        COALESCE(y.total_purchase, 0) AS total_purchase
    FROM expanded_years e
    LEFT JOIN yearly_sales y
        ON e.customer_id = y.customer_id AND e.year = y.year
),

-- Compare consecutive years
check_increase AS (
    SELECT
        f.customer_id,
        f.year,
        f.total_purchase,
        LEAD(f.total_purchase) OVER (PARTITION BY f.customer_id ORDER BY f.year) AS next_purchase
    FROM filled_sales f
)

-- Return customers who always increased
SELECT DISTINCT customer_id
FROM check_increase
GROUP BY customer_id
HAVING BOOL_AND(next_purchase > total_purchase)
ORDER BY customer_id;
