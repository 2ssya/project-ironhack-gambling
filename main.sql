USE ih_gambling;

-- Question 01:
SELECT Title, FirstName, LastName, DateOfBirth
FROM customer;

-- Question 02:
SELECT customer.CustomerGroup, COUNT(*)
FROM customer
GROUP BY CustomerGroup;

-- Question 03:
SELECT customer.* , account.CurrencyCode
FROM customer
JOIN account
ON customer.CustId = account.CustId;

-- Question 07:

SELECT c.Title, c.FirstName, c.LastName, COALESCE(SUM(b.Bet_Amt), 0) AS TotalBetAmt
FROM customer c
LEFT JOIN account a
ON c.CustId = a.CustId
LEFT JOIN betting b
ON a.AccountNo = b.AccountNo
AND b.BetDate >= "01/11/2012"
AND b.BetDate < "01/12/2012"
GROUP BY c.Title, c.FirstName, c.LastName
ORDER BY TotalBetAmt DESC;


-- Question 08 A:

SELECT c.Title, c.FirstName, c.LastName, COUNT(DISTINCT p.product) AS NumOfProduct
from customer c
JOIN account a
ON c.CustId = a.CustId
JOIN betting b 
ON a.AccountNo = b.AccountNo
JOIN product p 
ON b.ClassId = p.CLASSID
AND b.CategoryId = p.CATEGORYID
GROUP BY c.Title, c.FirstName, c.LastName;

-- Question 08 B:

SELECT c.Title, c.FirstName, c.LastName, GROUP_CONCAT(DISTINCT p.product) AS Products
from customer c 
JOIN account a 
ON c.CustId = a.CustId
JOIN betting b 
ON a.AccountNo = b.AccountNo
JOIN product p 
ON b.ClassId = p.CLASSID
AND b.CategoryId = p.CATEGORYID
WHERE p.product IN ("Sportsbook", "Vegas")
GROUP BY c.Title, c.FirstName, c.LastName
HAVING COUNT(DISTINCT p.product) = 2;













