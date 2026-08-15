------------------------------------------- SOLUTION -----------------------------------------
WITH state_cities_aggreggation AS (
    SELECT
        state,

    -- STEP 1: combine the cities in a string (seperated by ,) (STRING_AGG)
        STRING_AGG(city, ', ' ORDER BY city) AS cities,

    -- STEP 2: Compare FIRST_LETTER (state) = FIRST_LETTER (city) (LEFT)
        SUM(CASE WHEN LEFT(state, 1) = LEFT(city, 1) THEN 1 ELSE 0 END) AS matching_letter_count

    FROM cities
    GROUP BY state
    HAVING COUNT(city) >= 3
    )

-- STEP 3: include states that have at least 3 cities

SELECT *
FROM state_cities_aggreggation
WHERE matching_letter_count >= 1
ORDER BY matching_letter_count DESC, state ASC

--------------------------------------------- NOTES ------------------------------------------
--> GOAL:
    --> combine the cities in a string (seperated by ,)
    --> include states that have at least 3 cities
    --> only include states where FIRST_LETTER (state) = FIRST_LETTER (city)

--> ORDER BY
    --> count of matching letter DESC
    --> state name ASC
----------------------------------------------------------------------------------------------

-- QUESTION: do we have to order the cities in a specific order