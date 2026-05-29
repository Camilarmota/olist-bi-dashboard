-- 1. Receita total por mês
SELECT 
    DATE_TRUNC('month', order_purchase_timestamp) AS mes,
    SUM(price + freight_value) AS receita_total
FROM orders o
JOIN order_items i ON o.order_id = i.order_id
WHERE order_status = 'delivered'
GROUP BY 1 ORDER BY 1;

-- 2. Taxa de atraso por estado do cliente
SELECT 
    c.customer_state,
    COUNT(*) AS total_pedidos,
    SUM(CASE WHEN entrega_atrasada THEN 1 ELSE 0 END) AS atrasados,
    ROUND(100.0 * SUM(CASE WHEN entrega_atrasada THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_atraso
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY 1 ORDER BY 4 DESC;

-- 3. NPS simplificado por nota
SELECT
    review_score,
    COUNT(*) AS total,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 1) AS pct
FROM order_reviews
GROUP BY 1 ORDER BY 1;