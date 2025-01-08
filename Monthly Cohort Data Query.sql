-- SET SESSION sql_mode= (SELECT REPLACE(@@sql_mode, 'ONLY FULL GROUP BY', ''));
USE customer_churn;
SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

SELECT 
    p.purchase_id,
    p.subscription_id,
    CAST(p.purchase_date AS DATE) AS "Purchase Date",
    p.received_date,
    p.price,
    p.payment_provider,
    s.*
FROM
    purchases AS p
        JOIN
    students AS s ON p.student_id = s.student_id
WHERE
    p.refunded_date IS NULL
        AND p.subscription_type = 0
GROUP BY p.purchase_id;