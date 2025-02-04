DELIMITER //

CREATE PROCEDURE generate_sales_performance_report(
    IN p_start_date DATETIME,
    IN p_end_date DATETIME,
    IN p_report_type VARCHAR(20)
)
BEGIN
    -- Declare variables for storing temporary results
    DECLARE v_prev_start_date DATETIME;
    DECLARE v_prev_end_date DATETIME;
    
    -- Calculate previous period for comparison
    SET v_prev_start_date = DATE_SUB(p_start_date, INTERVAL DATEDIFF(p_end_date, p_start_date) DAY);
    SET v_prev_end_date = DATE_SUB(p_end_date, INTERVAL DATEDIFF(p_end_date, p_start_date) DAY);

    -- 1. Sales Overview
    WITH current_period_sales AS (
        SELECT 
            SUM(od.quantity * od.unit_price * (1 - od.discount)) as total_revenue,
            COUNT(DISTINCT o.id) as total_orders,
            COUNT(DISTINCT o.customer_id) as unique_customers
        FROM orders o
        JOIN order_details od ON o.id = od.order_id
        WHERE o.order_date BETWEEN p_start_date AND p_end_date
    ),
    previous_period_sales AS (
        SELECT 
            SUM(od.quantity * od.unit_price * (1 - od.discount)) as prev_revenue
        FROM orders o
        JOIN order_details od ON o.id = od.order_id
        WHERE o.order_date BETWEEN v_prev_start_date AND v_prev_end_date
    )
    SELECT 
        cps.total_revenue,
        cps.total_orders,
        cps.unique_customers,
        ((cps.total_revenue - pps.prev_revenue) / pps.prev_revenue * 100) as revenue_growth_percent
    FROM current_period_sales cps
    CROSS JOIN previous_period_sales pps;

    -- 2. Product Category Performance
    SELECT 
        p.category,
        SUM(od.quantity * od.unit_price * (1 - od.discount)) as category_revenue,
        SUM(od.quantity) as units_sold,
        SUM(od.quantity * (od.unit_price * (1 - od.discount) - p.standard_cost)) as gross_profit
    FROM orders o
    JOIN order_details od ON o.id = od.order_id
    JOIN products p ON od.product_id = p.id
    WHERE o.order_date BETWEEN p_start_date AND p_end_date
    GROUP BY p.category
    ORDER BY category_revenue DESC;

    -- 3. Top Products
    SELECT 
        p.product_name,
        p.category,
        SUM(od.quantity) as units_sold,
        SUM(od.quantity * od.unit_price * (1 - od.discount)) as product_revenue,
        SUM(od.quantity * (od.unit_price * (1 - od.discount) - p.standard_cost)) as product_profit
    FROM orders o
    JOIN order_details od ON o.id = od.order_id
    JOIN products p ON od.product_id = p.id
    WHERE o.order_date BETWEEN p_start_date AND p_end_date
    GROUP BY p.id, p.product_name, p.category
    ORDER BY product_revenue DESC
    LIMIT 10;

    -- 4. Inventory Analysis
    SELECT 
        p.product_name,
        p.category,
        p.reorder_level,
        (
            SELECT SUM(quantity)
            FROM inventory_transactions
            WHERE product_id = p.id
            GROUP BY product_id
        ) as current_stock,
        SUM(od.quantity) as period_sales
    FROM products p
    LEFT JOIN order_details od ON p.id = od.product_id
    LEFT JOIN orders o ON od.order_id = o.id AND o.order_date BETWEEN p_start_date AND p_end_date
    GROUP BY p.id, p.product_name, p.category, p.reorder_level
    HAVING current_stock <= p.reorder_level
    ORDER BY period_sales DESC;

    -- 5. Customer Analysis
    IF p_report_type = 'DETAILED' THEN
        SELECT 
            c.company,
            c.city,
            c.country_region,
            COUNT(DISTINCT o.id) as order_count,
            SUM(od.quantity * od.unit_price * (1 - od.discount)) as customer_revenue
        FROM customers c
        JOIN orders o ON c.id = o.customer_id
        JOIN order_details od ON o.id = od.order_id
        WHERE o.order_date BETWEEN p_start_date AND p_end_date
        GROUP BY c.id, c.company, c.city, c.country_region
        ORDER BY customer_revenue DESC
        LIMIT 20;

        -- 6. Geographic Distribution
        SELECT 
            o.ship_country_region,
            COUNT(DISTINCT o.id) as order_count,
            COUNT(DISTINCT o.customer_id) as customer_count,
            SUM(od.quantity * od.unit_price * (1 - od.discount)) as regional_revenue
        FROM orders o
        JOIN order_details od ON o.id = od.order_id
        WHERE o.order_date BETWEEN p_start_date AND p_end_date
        GROUP BY o.ship_country_region
        ORDER BY regional_revenue DESC;
    END IF;
END //

DELIMITER ;

-- Example usage:
-- CALL generate_sales_performance_report('2024-01-01 00:00:00', '2024-01-31 23:59:59', 'DETAILED');
-- CALL generate_sales_performance_report('2024-01-01 00:00:00', '2024-01-31 23:59:59', 'SUMMARY');
