-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    stock_name,
    SUM(CASE
            WHEN operation = 'Buy' THEN -price --''-' can be used to indicate that the amount is -'
            WHEN operation = 'Sell' THEN price
        END) AS capital_gain_loss
FROM
    stocks
GROUP BY
    stock_name
---------------------------------------------- NOTES --------------------------------------------
--> gain/loss for each stock = total gain/loss after buying/selling the stock one or many times
-------------------------------------------------------------------------------------------------