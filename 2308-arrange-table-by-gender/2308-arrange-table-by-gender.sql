--------------------------------------------- SOLUTION ------------------------------------------
with cte as (select user_id
       , gender
       , row_number() over (partition by gender order by user_id) rn
from genders
)
select user_id
        , gender
from cte
order by rn,  array_position(ARRAY['female', 'other', 'male'], gender)
---------------------------------------------- NOTES --------------------------------------------
--> rearrange the table in this order: female, other, male
--> ID of each gender are arranged ASC
-------------------------------------------------------------------------------------------------