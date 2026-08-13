# Learning-Platform-Performance-Analysis-Using-MySQL
An online learning platform sells various digital courses to learners across different countries. Each learner can purchase multiple courses, and each course belongs to a specific category.
Learning Platform Performance Analysis Using MySQL
📌 Project Overview

This project analyzes the performance of an online learning platform using MySQL. The analysis focuses on learners, courses, purchases, revenue, course performance, and learner spending patterns.

The project demonstrates how SQL can be used to transform transactional data into meaningful business insights and support data-driven decision-making.

🎯 Objectives
Analyze learner purchasing behavior.
Identify the most purchased courses.
Calculate total revenue and learner spending.
Analyze course and category performance.
Identify learners purchasing from multiple categories.
Find courses that have never been purchased.
Use advanced SQL concepts for analytical queries.
Create reusable SQL views for reporting.
🗄️ Database Structure

The project contains three main tables:

1. Learners

Stores learner information.

learners_id — Primary Key
learners_name
country
2. Courses

Stores course information.

courses_id — Primary Key
courses_name
category
unit_price
3. Purchases

Stores course purchase transactions.

purchases_id — Primary Key
learners_id — Foreign Key
courses_id — Foreign Key
quantity
purchases_date
🔗 Relationships
One learner can make multiple purchases.
One course can be purchased multiple times.
The purchases table connects learners and courses.
learners_id and courses_id act as foreign keys in the purchases table.
🛠️ Tools & Technologies
MySQL
MySQL Workbench
SQL
Relational Database Concepts
📊 Analysis Performed
Basic Analysis
Display learner purchase details.
Calculate total spending for each learner.
Find the top 3 most purchased courses.
Calculate revenue by course category.
Count unique learners in each category.
Advanced SQL Analysis
Identify learners who purchased courses from more than one category.
Find courses that were never purchased.
Compare learner spending against average spending.
Identify courses priced higher than courses in the Beginner category.
Analyze learner spending by country.
SQL Concepts Used
SELECT
WHERE
ORDER BY
GROUP BY
HAVING
INNER JOIN
LEFT JOIN
Aggregate Functions
Subqueries
Correlated Subqueries
CTEs
CASE expressions
NULL handling
Views
👁️ Key Business Questions
What is the total spending of each learner?
Which are the top 3 most purchased courses?
Which course categories generate the highest revenue?
Which learners purchased courses from multiple categories?
Which courses have never been purchased?
Which learners spend more than the average learner?
Which courses have prices higher than Beginner-category courses?
Which learners spend more than the average spending in their country?
📈 View Created

A reusable view named category_performance_view is created to summarize category-level performance.

It includes:

Category
Total Revenue
Number of Purchases
Average Revenue per Purchase

Example:

CREATE VIEW category_performance_view AS
SELECT
    c.category,
    SUM(p.quantity * c.unit_price) AS total_revenue,
    COUNT(p.purchases_id) AS number_of_purchases,
    AVG(p.quantity * c.unit_price) AS average_revenue_per_purchase
FROM courses c
JOIN purchases p
    ON c.courses_id = p.courses_id
GROUP BY c.category;
Business Insights

The analysis can help an online learning platform:

Identify high-performing courses and categories.
Understand learner purchasing behavior.
Improve course marketing strategies.
Identify courses with low or no demand.
Develop targeted offers for frequent learners.
Make better pricing and promotional decisions.
Monitor revenue performance across categories.
🚀 Conclusion

The Learning Platform Performance Analysis Using MySQL project demonstrates the practical use of SQL for business analysis. By combining joins, aggregate functions, subqueries, CTEs, CASE expressions, and views, the project converts purchase data into useful insights about learners, courses, revenue, and platform performance.

This project showcases practical SQL and data analytics skills and can be included as a portfolio project for a Data Analyst role.
