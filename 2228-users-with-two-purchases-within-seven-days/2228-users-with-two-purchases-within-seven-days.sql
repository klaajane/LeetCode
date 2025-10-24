--------------------------------------------- SOLUTION ------------------------------------------
SELECT DISTINCT
    p1.user_id
FROM 
    purchases p1
    JOIN  
        purchases p2
        ON p1.user_id = p2.user_id
        AND p1.purchase_id <> p2.purchase_id
        AND p2.purchase_date >= p1.purchase_date
WHERE
    ABS(p1.purchase_date - p2.purchase_date) <= 7
---------------------------------------------- NOTES --------------------------------------------
--> report IDs of the users with more than two purchaes <= 7
--> order by user_id
-------------------------------------------------------------------------------------------------