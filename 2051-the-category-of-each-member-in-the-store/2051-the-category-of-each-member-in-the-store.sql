-------------------------------------------- SOLUTION -------------------------------------------
WITH visit_metrics AS (
    SELECT
        v.member_id,
            100.0 * SUM(CASE 
                            WHEN p.visit_id IS NULL THEN 0
                            ELSE 1
                        END)
                /
            COALESCE(COUNT(*), 0) AS "conversion_rate"
    FROM
        visits v    
        LEFT JOIN 
            Purchases p
            ON p.visit_id = v.visit_id
    GROUP BY v.member_id
)

SELECT 
    m.member_id,
    m.name,
    CASE 
        WHEN vm.conversion_rate >= 80 THEN 'Diamond'
        WHEN vm.conversion_rate BETWEEN 50 AND 80 THEN 'Gold'
        WHEN vm.conversion_rate < 50 THEN 'Silver'
        WHEN vm.conversion_rate IS NULL THEN 'Bronze'
    END AS "category"
FROM
    Members m
    LEFT JOIN
        visit_metrics vm
        ON vm.member_id = m.member_id
ORDER BY 1 ASC
---------------------------------------------- NOTES --------------------------------------------
--> categorize members:
    --> "Diamond": if the conversion rate is greater than or equal to 80.
    --> "Gold": if the conversion rate is greater than or equal to 50 and less than 80.
    --> "Silver": if the conversion rate is less than 50.
    --> "Bronze": if the member never visited the store.
--> compute conversion rate:
    --> 100 * # of puchases / # visit 
-------------------------------------------------------------------------------------------------