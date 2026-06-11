-- Q1: Total Sales and Profit
SELECT 
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit
FROM orders;


-- Q2:best sales by Region
select region,sum(sales) as Total_Sales
From Orders 
GROUP by region 
order by Total_Sales DESC
LIMIT 1;


-- Q3: Most Profitable Category 
select category , round(sum(profit),2) as Total_Profit
from Orders
group by category 
order by Total_Profit DESC
limit 1; 


-- Q4: Sub_Categories with Losses
select sub_category , round(sum(profit),2) as Total_Profit 
from Orders
group by sub_category 
having Total_Profit < 0
order by Total_Profit ASC;


-- Q5: Impact of Discount on Profit
-- Insight: High discounts (>20%) cause losses
SELECT 
    CASE 
        WHEN discount < 0.10 THEN 'Low'
        WHEN discount < 0.20 THEN 'Medium' 
        ELSE 'High' 
    END AS Discount_Level,
    ROUND(SUM(profit), 2) AS Total_Profit
FROM orders
GROUP BY Discount_Level
ORDER BY Total_Profit DESC;


-- Q6: Top 5 Customers
select customer_name , sum(sales)As Total_Sales 
 from Orders
 group by customer_name
 order by Total_Sales DESC
 limit 5;


-- Q7: Top Sales Month
SELECT 
    "Month Name",
    ROUND(SUM(sales), 2) AS Total_Sales
FROM SuperStore
GROUP BY "Month Name"
ORDER BY Total_Sales DESC
LIMIT 1;
-- Result: December = highest sales month  


-- Q8: Customers Above Average Sales (Subquery)
SELECT customer_name, 
       ROUND(SUM(sales), 2) AS Total_Sales
FROM SuperStore
GROUP BY customer_name
HAVING Total_Sales > (SELECT AVG(sales) FROM SuperStore)
ORDER BY Total_Sales DESC;  


-- Q9: Sales & Profit by Region using JOIN
SELECT r.region, r.state,
       ROUND(SUM(s.sales), 2) AS Total_Sales,
       ROUND(SUM(s.profit), 2) AS Total_Profit
FROM SuperStore s
Inner JOIN regions r ON s.state = r.state
GROUP BY r.region, r.state
ORDER BY Total_Sales DESC
LIMIT 10;
-- Insight: Texas shows high sales but negative profit   


-- Q10: Top 5 by Sales UNION Top 5 by Profit
SELECT * FROM (
    SELECT customer_name,
           ROUND(SUM(sales), 2) AS Total_Value,
           'Top Sales' AS Type
    FROM SuperStore
    GROUP BY customer_name
    ORDER BY Total_Value DESC
    LIMIT 5
)
UNION ALL
SELECT * FROM (
    SELECT customer_name,
           ROUND(SUM(profit), 2) AS Total_Value,
           'Top Profit' AS Type
    FROM SuperStore
    GROUP BY customer_name
    ORDER BY Total_Value DESC
    LIMIT 5
);
-- Insight: Tamara Chand appears in both lists 



-- Q11: Regions with Above Average Sales (Subquery in HAVING)
SELECT region, 
       ROUND(AVG(sales), 2) AS Avg_Sales
FROM SuperStore
GROUP BY region
HAVING Avg_Sales > (SELECT AVG(sales) FROM SuperStore)
ORDER BY Avg_Sales DESC;
-- Insight: Central Asia leads with highest avg sales per order  



-- Q12: Regions Above Average Sales (Subquery inside FROM)
SELECT region, Total_Sales
FROM (
    SELECT region, 
           ROUND(SUM(sales), 2) AS Total_Sales
    FROM SuperStore
    GROUP BY region
    ORDER BY Total_Sales DESC
) AS sub
WHERE Total_Sales > (SELECT AVG(sales) FROM SuperStore);
-- Insight: Central leads all regions with 2.8M in sales
