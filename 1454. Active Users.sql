WITH base_calc AS (
    SELECT 
        t.id, 
        t.login_date, 
        DENSE_RANK() OVER(
            PARTITION BY t.id
            ORDER BY t.login_date ASC
        ) AS rnk, 

        DATEDIFF(
            t.login_date,
            MIN(t.login_date) OVER(
                PARTITION BY t.id
                ORDER BY t.login_date ASC
            ))
        AS days_between
    FROM (
        SELECT 
            DISTINCT id, login_date 
        FROM Logins 
    ) T

), 
    active_users_id AS (
        SELECT 
            id
        FROM base_calc 
        GROUP BY id, (
            CAST(rnk AS SIGNED) - CAST(days_between AS SIGNED)
        ) 
        HAVING COUNT(*) >= 5
        ORDER BY id ASC
 
    )
SELECT 
    DISTINCT U.id, 
    A.name
FROM active_users_id U
INNER JOIN Accounts A 
ON A.id = U.id
ORDER BY U.id ASC
