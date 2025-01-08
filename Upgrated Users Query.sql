SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));


USE customer_churn;
SELECT 
    o2.student_id,
    CASE
        WHEN o.subscription_type = 0 THEN 'Monthly'
        WHEN o.subscription_type = 2 THEN 'Annual'
        when o.subscription_type = 3 then 'lifetime'
    END AS 'Subscription Type',
    CASE
        WHEN o2.subscription_type = 0 THEN 'Monthly'
        WHEN o2.subscription_type = 2 THEN 'Aannual'
        when o2.subscription_type = 3 then 'Lifetime'
    END AS 'Upgrated Subscription Type',
    MAX(o.purchase_date) AS 'Latest Purchase Date',
    o2.CreatedAt,
    o.price AS 'First Purchase Type',
    o2.price AS 'Upgrated Subscription Price'
FROM
    (SELECT 
        student_id,
            MIN(purchase_date) AS CreatedAt,
            subscription_type,
            price,
            refunded_date
    FROM
        purchases
    WHERE
        (subscription_type = 2
            OR subscription_type = 3)
    GROUP BY student_id) AS o2
        INNER JOIN
    purchases AS o ON (
		o.student_id = o2.student_id
        AND o.subscription_type = 0 -- Filters for monthly subscriptions (For the first purchase).
        AND o.purchase_date < o2.CreatedAt -- monthly subscription was purchased before the earliest annual/lifetime purchase.
        AND o2.refunded_date IS NULL -- the annual/lifetime purchase was not refunded.
)
        JOIN
    students AS s ON s.student_id = o.student_id
GROUP BY CreatedAt;
-- Error Code: 1055. Expression #3 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'customer_churn.purchases.subscription_type' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
