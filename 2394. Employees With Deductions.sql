WITH 
    CALC_EMP_HRS AS (
        SELECT 
            EMPLOYEE_ID, 
            SUM(
                CEIL(
                        TIMESTAMPDIFF(SECOND, IN_TIME, OUT_TIME) / 60
                    ) 
            ) AS TOTAL_DURATION 
        FROM LOGS 
        GROUP BY EMPLOYEE_ID
    ), 

    CALC_VALID_EMP AS (
        SELECT 
            E.EMPLOYEE_ID, 
            COALESCE(C.TOTAL_DURATION, 0) AS WORKED_HOURS, 
            E.NEEDED_HOURS * 60 AS NEEDED_HOURS 
        FROM EMPLOYEES E 
        LEFT JOIN CALC_EMP_HRS C 
        ON 
            E.EMPLOYEE_ID = C.EMPLOYEE_ID 
    )


    SELECT 
        EMPLOYEE_ID
    FROM CALC_VALID_EMP 
    WHERE WORKED_HOURS < NEEDED_HOURS
