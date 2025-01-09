/* Employee and Sales Performance Analytics Script
This SQL script is designed to analyze employee and sales data by combining multiple datasets, performing calculations, and aggregating results to provide 
key performance insights. It can be used in various business intelligence and data analysis workflows to track performance at individual and departmental levels.

Key Objectives:
Data Consolidation: Merges employee and sales data for analysis.
Performance Metrics: Calculates:
Sales per employee.
Performance ratings (High, Mid, Low) based on scores.
Aggregated Insights: Summarizes department-level metrics like total sales and average performance scores.

Core Functionalities:
Combining Data: Joins employee and sales data using Employee_ID.
Calculations:
Sales per employee via grouping or window functions.
Performance ratings based on score thresholds.
Aggregation: Computes department-level summary statistics:
Total sales.
Average performance scores.

Applications:
Data Analysis: Creating performance reports.
Dashboards: Feeding data into visualization tools.
Performance Tracking: Monitoring employee performance and department outcomes.
*/

/* Combining Data Sources */
SELECT 
Name, Department, SUM(Sales_Amount) 
FROM 
Employee_Data 
INNER JOIN 
Sales_Data
ON 
Employee_Data.EmployeeID  = Sales_Data.EmployeeID
GROUP BY 
EmployeeID, Department;

/* SQL Join in Data Processing Pipeline */
SELECT 
e.Employee_ID, e.Name, e.Department, e.Performance_Score, s.Sales_Amount 
FROM 
Employee_Dataset e
LEFT JOIN 
Sales_Dataset s 
ON 
e.Employee_ID = s.Employee_ID 
WHERE 
e.Status = 'Active';

/* Calculate Sales per Employee */
SELECT
Name, Department, 
Sales_Amount /COUNT(EmployeeID) OVER(PARTION BY Department) AS Sales_Per_Employee
FROM
Combined_Dataset;

/* Calculate Performance Rating */
SELECT
EmployeeID, Department,
CASE
	WHEN Performance_Score >= 85 THEN ‘High_Performer’
	WHEN Performance_Score >= 70 THEN ‘Mid_Performer’
	ELSE ‘Low_Performer’
END AS Performance_Rating;
FROM
Employee_Dataset

/* Aggregate Sales and Performance by Department */  
SELECT
AVG(Performance_Score) AS Avg_PerformanceScore,
SUM(Sales_Amount) AS Total_Sales
FROM
Combined_Dataset
GROUP BY
Department;


