-- ANNUAL COHORT ORDERS

SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
USE customer_churn;


SELECT 
    
    p.purchase_id,
    p.subscription_id,
    CAST(p.purchase_date AS DATE) AS "Purchase Date",
    p.received_date, 
    p.price,
    p.payment_provider,
    p.subscription_type,
    s.*
    
FROM
    purchases AS p
        JOIN
    students AS s ON s.student_id = p.student_id
WHERE p.refunded_date IS NULL
AND p.subscription_type = 2
GROUP BY p.purchase_id;
    