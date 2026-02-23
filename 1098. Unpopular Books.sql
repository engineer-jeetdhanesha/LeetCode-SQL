WITH valid_books AS (
    SELECT 
        * 
    FROM Books 
    WHERE TIMESTAMPDIFF(MONTH, available_from, "2019-06-23") >= 1
)

SELECT 
    B.book_id, 
    B.name
FROM valid_books B  
LEFT JOIN (
    SELECT * FROM Orders 
    WHERE
    dispatch_date >= DATE_SUB("2019-06-23", INTERVAL 1 YEAR)
) O 
ON B.book_id = O.book_id 
GROUP BY B.book_id 
HAVING SUM(
        CASE 
            WHEN O.quantity IS NULL 
                THEN 0 
            ELSE O.quantity
        END
    )  < 10
