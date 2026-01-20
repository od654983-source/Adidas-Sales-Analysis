USE testdb
GO

SELECT * FROM dbo.Data_Sales_Adidas;

-- Data Cleaning

DELETE FROM Data_Sales_Adidas

WHERE Retailer = 'Retailer';
-- Questions discovered from the spreadsheet.

--Q1- What is the total sales

SELECT
      SUM([Total_Sales]) AS Total_Sales
FROM Data_Sales_Adidas;

--Q2- What is the total number of Units Sold?

SELECT
      SUM([Units_Sold]) AS Total_Unit_Sold
FROM Data_Sales_Adidas;

--Q3- what was the total number of sales?

SELECT
      COUNT(DISTINCT [Invoice_Data]) AS Total_Invoices
FROM Data_Sales_Adidas;

--Q4- what is the total sales amount for each Retailer?

SELECT 
      Retailer,
      SUM([Total_Sales]) AS Total_Sales
FROM Data_Sales_Adidas
GROUP BY Retailer
ORDER BY Total_Sales DESC;
      

--Q5- What are the top 5 product by total sales?

SELECT TOP 5
           Product,
           SUM([Total_Sales]) AS Total_Sales
FROM Data_Sales_Adidas
GROUP BY Product
ORDER BY Total_Sales DESC;

--Q6- What is the total profit per Region?

SELECT 
      Region,
      SUM([Profit]) AS Total_Profit
FROM Data_Sales_Adidas
GROUP BY Region
ORDER BY Total_Profit DESC;

--Q7- Which state had the highest sales?

SELECT TOP 1
           State,
           SUM([Total_Sales]) AS Total_Sales
FROM Data_Sales_Adidas
GROUP BY State
ORDER BY Total_Sales DESC;


--Q8- Which city is best for profits?

SELECT TOP 1
    City,
    SUM([Profit]) AS Total_Profit
FROM Data_Sales_Adidas
GROUP BY City
ORDER BY Total_Profit DESC;


--Q9- What is average profit margin per product?

SELECT 
    Product,
    AVG([Operating_Margin]) AS Avg_Operating_Margin
FROM Data_Sales_Adidas
GROUP BY Product
ORDER BY Avg_Operating_Margin DESC;


--Q10- What are the monthly sales?

SELECT
      YEAR([Invoice_Data]) AS Sales_year,
      MONTH([Invoice_Data]) AS Sales_Month,
      SUM([Total_Sales]) AS Monthly_Sales
FROM Data_Sales_Adidas
GROUP BY YEAR([Invoice_Data]) , MONTH([Invoice_Data])
ORDER BY Sales_Month , Sales_year , Monthly_Sales DESC;

--Q11- What is the total sales each year?

SELECT
      YEAR([Invoice_Data]) AS Sales_year,
      SUM([Total_Sales]) AS Total_Sales
FROM Data_Sales_Adidas
GROUP BY YEAR([Invoice_Data]) 
ORDER BY Sales_year , Total_Sales DESC;

--Q12- Which Sales method achieved the highest sales?

SELECT 
      Sales_Method,
      SUM([Total_Sales]) AS Total_Sales
FROM Data_Sales_Adidas
GROUP BY Sales_Method
ORDER BY Total_Sales DESC;


--Q13- Which Sales methods achieved profitability?

SELECT 
      Sales_Method,
      SUM([Profit]) AS Total_Profit
FROM Data_Sales_Adidas
GROUP BY Sales_Method
ORDER BY Total_Profit DESC;


--Q14- what is the top-selling product in each region?

WITH ProductSales AS (
    SELECT 
        Region,
        Product,
        SUM([Total_Sales]) AS Total_Sales,
        RANK() OVER (
            PARTITION BY Region 
            ORDER BY SUM([Total_Sales]) DESC
        ) AS Rank_In_Region
    FROM Data_Sales_Adidas
    GROUP BY Region, Product
)
SELECT 
    Region,
    Product,
    Total_Sales
FROM ProductSales
WHERE Rank_In_Region = 1
ORDER BY Total_Sales DESC;


--Q15- what is the Ranking of states by sales?

SELECT 
    State,
    SUM([Total_Sales]) AS Total_Sales
FROM Data_Sales_Adidas
GROUP BY State
ORDER BY Total_Sales DESC;


--Q16- Which products performed above average in the same quarter?

SELECT DISTINCT
    Product
FROM Data_Sales_Adidas
WHERE [Operating_Margin] > (
    SELECT AVG([Operating_Margin]) 
    FROM Data_Sales_Adidas
);

                                      





