-- create schema retailshop;
 use retailshop;
describe online_retail;

-- QUESTION 1

SELECT CustomerID, sum(Quantity * UnitPrice) AS TotalOrderValue
FROM online_retail
GROUP BY CustomerID
ORDER BY TotalOrderValue DESC;

-- QUESTION 2

SELECT CustomerID, count(DISTINCT StockCode) AS UniqueProducts
FROM online_retail
GROUP BY CustomerID;

-- QUESTION 3

SELECT CustomerID, count(*) AS PurchaseCount
FROM online_retail
GROUP BY CustomerID
HAVING PurchaseCount = 1;

-- QUESTION 4 

SELECT t1.StockCode AS Product1, t2.StockCode AS Product2, COUNT(*) AS Frequency
FROM online_retail t1
JOIN online_retail t2 ON t1.InvoiceNo = t2.InvoiceNo AND t1.StockCode < t2.StockCode
GROUP BY Product1, Product2
ORDER BY Frequency DESC;

 -- QUESTION 1
 
WITH CustomerPurchaseFrequency AS (
SELECT CustomerID, count(*) AS PurchaseFrequency
FROM online_retail
GROUP BY  CustomerID
)
SELECT CustomerID, PurchaseFrequency,
CASE
WHEN PurchaseFrequency >= 10 THEN "High Frequency"
WHEN PurchaseFrequency BETWEEN 5 AND 9 THEN "Medium Frequency"
ElSE "low Frequency"
END AS CustomerSegment
FROM CustomerPurchaseFrequency;

-- QUESTION 2

 SELECT CountrY, avg(Quantity * UnitPrice) AS AverageOrderValue
 FROM online_retail
 GROUP BY Country
 ORDER BY AverageOrderValue DESC;

-- QUESTION 3

SELECT CustomerID, MAX(InvoiceDate) AS LastPurchaseDate
FROM online_retail
GROUP BY CustomerID
HAVING MAX(InvoiceDate) < DATE_SUB(NOW(), INTERVAL 6 MONTH);

-- QUESTION 4

WITH ProductPairs AS (
  SELECT t1.StockCode AS Product1, t2.StockCode AS Product2
  FROM online_retail t1
  JOIN online_retail t2 ON t1.InvoiceNo = t2.InvoiceNo AND t1.StockCode < t2.StockCode
)
SELECT Product1, Product2, COUNT(*) AS Frequency
FROM ProductPairs
GROUP BY Product1, Product2
ORDER BY Frequency DESC;

-- QUESTION 5 

SELECT MONTH(InvoiceDate) AS Month, SUM(Quantity * UnitPrice) AS TotalSales
FROM online_retail
GROUP BY MONTH(InvoiceDate)
ORDER BY MONTH(InvoiceDate);
