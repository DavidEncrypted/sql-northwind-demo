DELIMITER //

CREATE PROCEDURE orders_per_month_report(IN target_year INT)
BEGIN
    SELECT 
        MONTHNAME(order_date) as month,
        COUNT(*) as total_orders
    FROM orders
    WHERE YEAR(order_date) = target_year
    GROUP BY MONTH(order_date), MONTHNAME(order_date)
    ORDER BY MONTH(order_date);
END //

DELIMITER ;
