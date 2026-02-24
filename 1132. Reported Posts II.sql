WITH base_calc AS (
    SELECT 
        A.action_date, 
        COUNT(DISTINCT R.post_id) AS post_removed_count, 
        COUNT(DISTINCT A.post_id) AS post_marked_spam_count
    FROM (
        SELECT * 
        FROM Actions 
        WHERE action = 'report' 
        AND extra = 'spam'
    ) A 
    LEFT JOIN Removals R 
    ON 
        A.post_id = R.post_id 
    GROUP BY A.action_date
)

SELECT 
    ROUND(
        SUM(
            post_removed_count  / post_marked_spam_count
        ) * 100 / COUNT(*)
    , 2) AS  average_daily_percent 
FROM base_calc 

    
