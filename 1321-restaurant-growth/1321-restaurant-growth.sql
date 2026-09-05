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

--> RANGE is appropriate here because the requirement is based on a date interval ratehre than the number of rows
--> ROWS means six preceding rows, not six preceding calendar days

WITH customers_metrics AS (
    SELECT
    visited_on,

    ROUND(SUM(amount) OVER w, 2) AS amount,

    ROUND(AVG(amount) OVER w, 2) AS average_amount
    
    FROM (
        SELECT visited_on, SUM(amount) AS amount
        FROM customer
        GROUP BY visited_on
    )
    
    WINDOW w AS (
    ORDER BY visited_on
    RANGE BETWEEN INTERVAL '6 DAYS' PRECEDING
              AND CURRENT ROW

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
    
-- if this was a real porduction table with a lot of data:
    --> Do we have an index on visited_on?

-- CREATE INDEX indx_customer_visited_on
-- on customer(visited_on)

-- can make the query readable using WINDOW, since we have the same window logic repeated in the query



-- moving avg of $ paid by customers in a seven days window (current day + 6 days)
-- round to 2 decimal places
-- order by visited_on ASC

-- question to ask: can there be more that one customer per day?