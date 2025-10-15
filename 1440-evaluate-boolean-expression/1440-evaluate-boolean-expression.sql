--------------------------------------------- SOLUTION ------------------------------------------
WITH values AS (
    SELECT
        e.*,
        v1.value "value1",
        v2.value "value2"
    FROM
        expressions e
    INNER JOIN
        variables v1
        ON v1.name = e.left_operand
    INNER JOIN
        variables v2
        ON v2.name = e.right_operand)

SELECT
    left_operand,
    operator,
    right_operand,
    CASE
        WHEN operator = '=' AND value1 = value2 THEN 'true'
        WHEN operator = '>' AND value1 > value2 THEN 'true'
        WHEN operator = '<' AND value1 < value2 THEN 'true'
        ELSE 'false'
    END AS "value"
FROM
    values
    ---OR v.name = e.right_operand
---------------------------------------------- NOTES --------------------------------------------
--> 
-------------------------------------------------------------------------------------------------