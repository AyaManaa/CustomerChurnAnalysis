USE customer_churn;

SET SESSION sql_mode= (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

WITH active_users AS(
	SELECT
		student_id,
		DATE_FORMAT(subscription_period_start, '%Y-%m')AS month,
		subscription_type
    FROM
		subscriptions AS s
        JOIN students AS st USING(student_id)
	WHERE 
		cancelled_date IS NULL
        AND next_charge_date >= DATE_FORMAT(s.subscription_period_start, '%Y-%m-01')
        AND (subscription_type = 0 OR subscription_type= 2 OR subscription_type= 1)
	GROUP BY 
		student_id, month
), 
cancelled_users AS(
	SELECT
		student_id,
        DATE_FORMAT(cancelled_date, '%Y-%m') as cancel_month,
        subscription_type
	FROM 
		subscriptions
        JOIN students USING(student_id)
	WHERE
		cancelled_date IS NOT NULL
        AND (subscription_type = 0 OR subscription_type = 2 OR subscription_type = 1)
	GROUP BY 
		student_id,
        cancel_month
), end_users AS ( -- users who didn't renew their subscriptions but Didn't Cancel
	SELECT
		student_id,
        DATE_FORMAT(end_date, '%Y-%m') AS end_month,
        subscription_type
	FROM 
		subscriptions
        JOIN students USING(student_id)
	WHERE
		state IS NOT NULL
        AND cancelled_date IS NULL
        AND (subscription_type = 0 OR subscription_type= 1 OR subscription_type= 2)
	GROUP BY student_id
), 
count_end_users AS (
	SELECT
		end_month,
        COUNT(*) AS number_of_end_users
	FROM 
		end_users
	GROUP BY 
		end_users.end_month
	ORDER BY 
		end_users.end_month ASC
) 
	SELECT 
		active_users.month,
		COUNT(DISTINCT(active_users.student_id)) AS active_users,
		SUM(COUNT(DISTINCT(active_users.student_id))) OVER (ORDER BY active_users.month) AS Sum_active_users,
		COUNT(DISTINCT(cancelled_users.student_id)) AS cancelled_users,
		COALESCE(number_of_end_users, 0) AS 'NumberOfEndUsers'	,
		(COUNT(DISTINCT(cancelled_users.student_id)) + number_of_end_users) / (SUM(COUNT(DISTINCT(active_users.student_id))) OVER (ORDER BY active_users.month)) * 100 AS churn_rate, -- Summition of Passive & Active by adding Cancelled users & end users
		(COUNT(DISTINCT(cancelled_users.student_id)) / SUM(COUNT(DISTINCT(active_users.student_id))) OVER (ORDER BY active_users.month)) * 100 AS active_churn_rate,
		(number_of_end_users / SUM(COUNT(DISTINCT(active_users.student_id))) OVER (ORDER BY active_users.month)) * 100 AS passive_churn_rate,
		active_users.subscription_type
	FROM
		active_users 
		LEFT JOIN cancelled_users ON cancelled_users.cancel_month = active_users.month
		LEFT JOIN count_end_users ON count_end_users.end_month = active_users.month
		JOIN students ON students.student_id = active_users.student_id
	GROUP BY active_users.month
	ORDER BY  active_users.month ASC;
