USE customer_churn;
-- RESSURCTED QUERY
SELECT 
    s.student_id,
    s.subscription_id AS 'First Subscription ID',
    s2.subscription_id AS 'Ressurected Subscription ID',
    s.state AS 'First State',
    s2.state AS 'Ressurected State',
    s.created_date AS 'First Created Date',
    s.subscription_period_start AS 'First Subscription Start Date',
    s.next_charge_date AS 'First Charge Date',
    s.end_date AS 'First End Date',
    DATEDIFF(CAST(s2.created_date AS DATE),
            CAST(s.end_date AS DATE)) AS 'Ressiraction Days',
    s2.created_date AS 'Ressurected Created Date',
    s2.subscription_period_start AS 'Ressurected Subscription Start Date',
    s2.next_charge_date AS 'Ressurected Charge Date',
    s2.end_date AS 'Ressurected End Date',
    s.cancelled_date AS 'First Cancel Date',
    s2.cancelled_date AS 'Ressurected Cancel Date',
    CASE
        WHEN s.subscription_type = 0 THEN 'Monthly'
        WHEN s.subscription_type = 2 THEN 'Annualy'
        WHEN s.subscription_type = 3 THEN 'Life Time'
    END AS 'First Subscription Type',
    CASE
        WHEN s2.subscription_type = 0 THEN 'Monthly'
        WHEN s2.subscription_type = 2 THEN 'Annualy'
        WHEN s.subscription_type = 3 THEN 'Life Time'
    END AS 'Ressurected Subscription Type'
FROM
    subscriptions AS s
        INNER JOIN
    subscriptions AS s2 ON (s.student_id = s2.student_id
        AND s.subscription_id != s2.subscription_id
        AND s2.subscription_id > s.subscription_id
        AND s2.created_date > s.created_date)
WHERE
    DATEDIFF(s2.created_date, s.end_date) > 1
GROUP BY s.student_id
ORDER BY s.student_id;

SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
