WITH all_distances AS (
    SELECT 
        P1.x AS P1_x,
        P1.y AS P1_y, 
        P2.x as P2_x, 
        P2.y AS P2_y, 
        ROUND(
                POWER( 
                    POWER(P2.x-P1.x, 2) +  POWER(P2.y-P1.y, 2)
                    , 0.5
                ) 
            ,2) AS distance_bw_P1_and_P2

    FROM Point2D P1 
    CROSS JOIN Point2D P2 
    WHERE P1.x != P2.x OR P1.y != P2.y
)

SELECT MIN(distance_bw_P1_and_P2) AS shortest 
FROM all_distances