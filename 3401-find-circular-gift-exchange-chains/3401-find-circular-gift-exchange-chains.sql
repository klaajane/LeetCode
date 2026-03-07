-- recursion problem:


-- anchor query:
WITH recursive chains AS (
    SELECT
        giver_id AS "start_id",
        receiver_id AS "current_id",
        gift_value "total_gift_value",
        1 AS "chain_length"
    FROM SecretSanta

    UNION ALL

    SELECT 
        c.start_id,
        s.receiver_id AS "current_id",
        c.total_gift_value + s.gift_value,
        c.chain_length + 1
    FROM chains c
    JOIN SecretSanta s ON s.giver_id = c.current_id
    WHERE c.start_id <> c.current_id)

SELECT
    ROW_NUMBER () OVER (ORDER BY  chain_length DESC,
                        total_gift_value DESC) AS "chain_id",
    chain_length,
    total_gift_value
FROM chains
WHERE start_id = current_id
GROUP BY chain_length, total_gift_value
ORDER BY chain_length DESC, total_gift_value DESC