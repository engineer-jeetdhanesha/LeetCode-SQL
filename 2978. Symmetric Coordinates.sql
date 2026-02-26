WITH base_coordinates AS (
    SELECT 
        *, 
        ROW_NUMBER() OVER(ORDER BY X) AS rn
    FROM Coordinates
)
SELECT
    DISTINCT C1.X, C1.Y
FROM base_coordinates C1 
INNER JOIN base_coordinates C2 
ON 
    C1.X = C2.Y 
    AND C2.X = C1.Y 
    AND C1.X <= C1.Y
    AND  C1.rn != C2.rn 
ORDER BY C1.X, C1.Y