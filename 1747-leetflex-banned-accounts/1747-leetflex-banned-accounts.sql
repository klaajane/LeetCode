--------------------------------------------- SOLUTION ------------------------------------------
SELECT DISTINCT
    a.account_id
FROM
    LogInfo a
CROSS JOIN
    LogInfo b
WHERE
    a.account_id = b.account_id
    AND a.ip_address != b.ip_address
    AND a.login <= b.logout
    AND a.logout >= b.login
---------------------------------------------- NOTES --------------------------------------------
--> find accounts that shoulda been banned (logged in from two different IP addresses)
-------------------------------------------------------------------------------------------------