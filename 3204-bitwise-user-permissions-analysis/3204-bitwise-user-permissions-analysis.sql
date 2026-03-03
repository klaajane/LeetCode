--------------------------------------------- SOLUTION ------------------------------------------
SELECT
    BIT_AND(permissions) AS common_perms,
    BIT_OR(permissions)  AS any_perms
FROM user_permissions;
---------------------------------------------THOUGHTS--------------------------------------------
-- PostgreSQL's BIT_AND() and BIT_OR() are native aggregates — no GROUP BY needed since
-- we want a single result across all users.
--------------------------------------------------------------------------------------------------