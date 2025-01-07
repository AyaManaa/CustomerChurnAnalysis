A. Data Preparations:
  1. In the Customer Churn Database, contains three tables:
      1. Purchases Table
      2. Students Table
      3. Subscription Table
  2. Created The Following Queries:
      1. Revenue Data Query:
          -> This query was created to get the student, purchase IDs, and the student's Country. Created a subscription Type (Monthly, Annual, or Lifetime), Revenue Type (New, or Recurring), and Refundes (Revenue,                 or Refunded) columns  using the CASE statement. Grouping by the purchase ID using the data from the Purchases and Students tables using INNER JOIN
      2. Ressurected Data Query:
          -> This query was created to Collect the data of the resurrected students, who didn't renew but resubscribed after a while. Created First Subscription Type and Ressurected Subscription Type columns usin                  the CASE statement. Using SELF JOIN on the Subscriptions table and Grouping By the Student ID.
      3. 
