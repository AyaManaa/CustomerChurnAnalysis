USE customer_churn;


SELECT 
    p.purchase_id,
    p.student_id,
    CASE
        WHEN p.subscription_type = 0 THEN 'Monthly'
        WHEN p.subscription_type = 2 THEN 'Anually'
        ELSE 'Life Time'
    END AS 'Subscription Type',
    p.refund_id,
    p.refunded_date,
    MIN(p.purchase_date) AS 'First Purchase Date',
    p2.purchase_date AS 'Current Purchase Date',
    p.price,
    CASE 
		WHEN MIN(p.purchase_date) = p2.purchase_date THEN "New"
        ELSE "Recurring"
    END  AS "Revenue Type",
    
    CASE
        WHEN p.refunded_date IS NULL THEN 'Revenue'
        ELSE 'Refunded'
    END AS 'Refundes',
    s.student_country
FROM
    purchases AS p
        INNER JOIN
    purchases AS p2 ON p.student_id = p2.student_id
        INNER JOIN
    students AS s ON p.student_id = s.student_id
GROUP BY p.purchase_id
ORDER BY p.purchase_date;
    
    

SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
