DELIMITER //

CREATE PROCEDURE orders_per_year_report()
BEGIN
    SELECT 
        YEAR(order_date) as year,
        COUNT(*) as total_orders
    FROM orders
    GROUP BY YEAR(order_date)
    ORDER BY year;
END //

DELIMITER ;
