--------------------------------------------- SOLUTION ------------------------------------------
WITH gender_ordered AS (
    SELECT
        user_id,
        gender,
        ROW_NUMBER() OVER (PARTITION BY gender
                            ORDER BY user_id ASC) "r_num",
        CASE WHEN gender = 'female' THEN 1
             WHEN gender = 'other' THEN 2
             WHEN gender = 'male' THEN 3
        END AS "gender_order"
    FROM
        Genders)

SELECT
    user_id,
    gender
FROM
    gender_ordered
ORDER BY r_num, gender_order 
---------------------------------------------- NOTES --------------------------------------------
--> rearrange the table in this order: female, other, male
--> ID of each gender are arranged ASC
-------------------------------------------------------------------------------------------------