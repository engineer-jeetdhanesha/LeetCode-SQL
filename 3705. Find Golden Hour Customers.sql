SELECT 
    customer_id, 
    COUNT(*) AS total_orders, 
    ROUND(
        SUM(
            CASE 
                WHEN EXTRACT(HOUR FROM order_timestamp) IN (
                    '11', '12', '13', '18', '19', 
                    '20'
                ) THEN 1 
                ELSE 0 
            END 
        ) * 100 / COUNT(*) , 0) AS peak_hour_percentage,
    ROUND( SUM(order_rating) / COUNT(order_rating) , 2) AS average_rating
    
FROM restaurant_orders 
GROUP BY customer_id 
HAVING 
    total_orders >= 3
    AND peak_hour_percentage >= 60
    AND average_rating >= 4.0 
    AND ROUND( COUNT(order_rating)*100 / COUNT(*) , 2) >= 50
ORDER BY average_rating DESC, customer_id DESC