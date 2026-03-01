WITH 
    CALC_WEEKLY_MEETING_HOURS AS (
        SELECT 
            EMPLOYEE_ID, 
            WEEK(MEETING_DATE, 1) AS WEEK_NUM, 
            SUM(DURATION_HOURS) AS WEEKLY_MEETING_HOURS,
            CASE 
                WHEN SUM(DURATION_HOURS) > 20 
                    THEN 'MEETING_HEAVY'
                ELSE 'MEETING_LIGHT'
            END AS WEEK_TYPE
        FROM MEETINGS  
        GROUP BY EMPLOYEE_ID, WEEK(MEETING_DATE, 1)
    ), 

    CALC_EMPLOYEE_WEEKLY_STATS AS (
        SELECT
            EMPLOYEE_ID, 
            WEEK_TYPE, 
            SUM(
            CASE 
                WHEN WEEK_TYPE = 'MEETING_HEAVY' THEN 1 ELSE 0 END
            ) AS MEETING_HEAVY_WEEKS
        FROM CALC_WEEKLY_MEETING_HOURS 
        GROUP BY EMPLOYEE_ID, WEEK_TYPE 
        HAVING MEETING_HEAVY_WEEKS >=2 

    )

SELECT 
    E.EMPLOYEE_ID AS employee_id, 
    E.EMPLOYEE_NAME AS employee_name, 
    E.DEPARTMENT AS department,   
    MEETING_HEAVY_WEEKS AS meeting_heavy_weeks
FROM EMPLOYEES E 
INNER JOIN CALC_EMPLOYEE_WEEKLY_STATS S 
ON E.EMPLOYEE_ID = S.EMPLOYEE_ID 
ORDER BY meeting_heavy_weeks DESC, employee_name ASC
