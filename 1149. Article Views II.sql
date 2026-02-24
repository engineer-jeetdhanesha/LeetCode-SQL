WITH unique_article_counts AS (
    SELECT 
        viewer_id, 
        view_date, 
        COUNT(DISTINCT article_id) AS article_count
    FROM Views 
    GROUP BY viewer_id, view_date
)

SELECT 
    DISTINCT(viewer_id) AS id 
FROM unique_article_counts 
WHERE article_count > 1 
ORDER BY id ASC