Create database assignment3
use assignment3

select * from Orders_Dirty

--Count rows & distinct OrderIDs
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT OrderID) AS unique_orders
FROM Orders_Dirty;

--Count NULL values
SELECT 
    COUNT(*) AS missing_rating
FROM Orders_Dirty
WHERE Rating IS NULL;

--Find duplicates
SELECT OrderID, COUNT(*) AS count
FROM Orders_Dirty
GROUP BY OrderID
HAVING COUNT(*) > 1;

--Identify invalid data
SELECT *
FROM Orders_Dirty
WHERE Quantity <= 0
   OR UnitPrice <= 0
   OR Rating < 1 OR Rating > 5;

--Clean data (UPDATE / DELETE)
--Replace NULL Rating
UPDATE Orders_Dirty
SET Rating = 0
WHERE Rating IS NULL;

--Delete invalid rows
DELETE FROM Orders_Dirty
WHERE Quantity <= 0 OR UnitPrice <= 0;

--Revenue by category
SELECT Category,
       SUM(Quantity * UnitPrice * (1 - Discount_Pct/100.0)) AS Revenue
FROM Orders_Dirty
GROUP BY Category
ORDER BY Revenue DESC;

--Top cities
SELECT TOP 5 City,
       SUM(Quantity * UnitPrice) AS Revenue
FROM Orders_Dirty
GROUP BY City
ORDER BY Revenue DESC;

--Top customers
SELECT TOP 5 Customer_Name,
       SUM(Quantity * UnitPrice) AS Revenue
FROM Orders_Dirty
GROUP BY Customer_Name
ORDER BY Revenue DESC;

--Monthly trends
SELECT 
    MONTH(OrderDate) AS Month,
    SUM(Quantity * UnitPrice) AS Revenue
FROM Orders_Dirty
GROUP BY MONTH(OrderDate)
ORDER BY Month;

--Rating analysis
SELECT Rating,
       COUNT(*) AS count
FROM Orders_Dirty
GROUP BY Rating
ORDER BY Rating;

