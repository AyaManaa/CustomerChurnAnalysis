This project involves analyzing customer churn using Tableau to derive insights from the data. The data preparation was done using SQL, followed by visualization in Tableau.
# A. Data Preparations:
  - Used My SQL to extract CSV files from the tables existing in the database, to facilitate analyzing customer churn in Tableau
  1. In the Customer Churn Database, contains three tables:
      1. Purchases Table
      2. Students Table
      3. Subscription Table
         
  2. Created The Following Queries:
      1. Revenue Data Query:
          
          - This query was created to get the student, purchase IDs, and the student's Country. Created a subscription Type (Monthly, Annual, or Lifetime), Revenue                Type (New, or Recurring), and Refundes (Revenue, or Refunded) columns  using the CASE statement. Grouping by the purchase ID using the data from the                 Purchases and Students tables using INNER JOIN
      2. Ressurected Data Query:      
          - This query was created to Collect the data of the resurrected students, who didn't renew but resubscribed after a while—created First Subscription Type                   and Ressurected Subscription Type columns using the CASE statement. Using SELF JOIN on the Subscriptions table and Grouping By the Student ID.
      3. Upgraded Users Query
          - This query extracts the students who upgraded their subscription plan From Monthly to either Annual Or Lifetime plan. I used SELF JOIN on the Purchases                 Table, then used INNER JOIN on the Students table.
      4. Active and Passive Churns
          - Active churn is those who after subscribing, they cancel their subscriptions. Passive Churn is those who don't cancel their subscription but they                       don't renew it either.
          - Used CTEs to create temporary tables for Active (those who subscribed), Cancelled, and End (Didn't Cancel but also didn't renew) Users.
      5. Monthly Cohort Analysis
          - This query extracts the Monthly subscription plans only that weren't refunded. Using INNER JOIN between Purchases and students, and Grouping By       
                 PurchasID
      6. Annual Cohort Analysis:
          - This query extracts Annual subscription plans only that weren't refunded. Using INNER JOIN between Purchases and students tables, and Grouping By
             PurchaseID 

# B. Data Visulization
  - Utilized Tableau's Story to create a cohesive and insightful narrative. By integrating Dashboards and visuals.
  1.  Revenue and Churn Rate Dashboard:
        - Used **Net Revenue and Refunds Bar Chart** to analyze the monthly Total Revenue and Refunds.
            - Applied Subscription Type, Date, Revenue Type, and Country filters for this visual.
            - **Key Findings**:
              - Nov 2021 has the highest Revenue (178.6k), then Jan 2022 (113.1k). While Oct 2021 has the lowest Revenue (18.6k)
        - Used **Churn Rate** Line Chart that illustrated Monthly Total Churn, Active Churn, and Passive Churn rates 
            - Applied Month Filter
            - **Key Findings**:
              - Dec 2021 has the highest *Total* Churn Rate 9.2% and the highest *Passive* churn approx 5% 
              - Jan 2022 has the highest *Active* hurn 5.14%
  2. New vs Recurring Revenue Type Visual:
        - Using a Combined bar and line chart to analyze the amount of new students vs recurring ones
        - **Key findings**:
          - Found that the number of students in Oct 2022 is larger than those in Oct 2021.
          - In Oct 2021, the number of recurring students is way higher than new students by 76.57%
          - In Nov 2021, the number of new students is relatively higher than the recurring ones by 73.2%
  3. Top 10 Revenues by Country Dahboard:
        - Revenue by Country Map Chart
        - Top 10 countries with the highest revenue, and their Average Order Value
  4. User Ressurection Dashboard:
        - It contains the number of resurrected users and Avg resurrection time KPIs. Also a user resurrection Bar chart with Subscription type
        - Using First and Ressurected subscription plan filters
  5. User Upgrades Visual:
        - Analyzed the number of students who upgraded their subscription plan, using a stacked bar chart with subscription type.
        - Added Orginal Subscription plan, and upgraded subscription Plan filters.
  6. Annual Cohort Dashboard
        - Heatmap Visualization representing Annual plan purchase counts and percentages over different periods, helping to understand customer retention and churn               over time.
  7. Monthly Cohort Dashboard:
        - Heatmap visualization representing Monthly plan purchases count and percentages over different periods, providing insights into short-term customer
              behavior.
        - Added year, and period filters
