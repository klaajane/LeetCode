--> clarifying questions:
    --> customer_id, visited_on is the primary key:
        --> am I safe to assume that customer_id cannot visit the restaurant during the same day?
    --> amount can never be negative
        --> in case if a customer requests a refund?

    --> is visited_on date continuous?

    --> what if we have less than 7 dates in our data?

--> typing out my pseudocode:
    --> compute the moving avg (INTERVAL + AVG)

--> WHERE only show records after the 6th

WITH customers_metrics AS (
    SELECT
        visited_on,
        SUM(amount) OVER (
            ORDER BY visited_on
            RANGE BETWEEN INTERVAL '6 DAYS' PRECEDING
            AND CURRENT ROW
        ) AS amount,
        ROUND(
            AVG(amount) OVER (
            ORDER BY visited_on
            RANGE BETWEEN INTERVAL '6 DAYS' PRECEDING
            AND CURRENT ROW
            )
            , 2) AS average_amount
    FROM (
        SELECT visited_on, SUM(amount) AS amount
        FROM customer
        GROUP BY visited_on
    )
)

SELECT
    visited_on,
    amount,
    average_amount
FROM customers_metrics
WHERE visited_on - (SELECT MIN(visited_on) FROM customer) >= 6
ORDER BY 
    visited_on ASC
    




-- moving avg of $ paid by customers in a seven days window (current day + 6 days)
-- round to 2 decimal places
-- order by visited_on ASC

-- question to ask: can there be more that one customer per day?