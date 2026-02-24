SELECT 
    gender, 
    day, 
    SUM(score_points) OVER(PARTITION BY gender ORDER BY gender ASC, day ASC) AS total
FROM Scores 
