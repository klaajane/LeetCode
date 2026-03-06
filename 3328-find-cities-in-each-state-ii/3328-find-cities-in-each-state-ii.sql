
-- Extract fisrt letter: 
SELECT
    state,
    STRING_AGG(city, ', ' ORDER BY city) AS "cities",
    SUM(CASE WHEN LEFT(state, 1) = LEFT(city, 1) THEN 1 ELSE 0 END) AS "matching_letter_count"
    --LEFT(state, 1) "state_first_letter",
    --LEFT(city, 1) "city_first_letter"
FROM cities
GROUP BY state
HAVING SUM(CASE WHEN LEFT(state, 1) = LEFT(city, 1) THEN 1 ELSE 0 END) > 0 
AND COUNT(city) >= 3
ORDER BY matching_letter_count DESC, state ASC