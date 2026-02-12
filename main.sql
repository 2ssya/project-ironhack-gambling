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

-- Question 04:
SELECT b.BetDate, p.product, SUM(b.Bet_Amt) AS total_bet
FROM betting b
JOIN product p 
ON b.ClassId = p.CLASSID 
AND b.CategoryId = p.CATEGORYID
GROUP BY b.BetDate, p.product
ORDER BY b.BetDate, total_bet DESC;
-- Question 05:
SELECT b.BetDate, p.product, SUM(b.Bet_Amt) AS total_bet
FROM betting b
JOIN product p 
ON p.CLASSID = b.ClassID
AND b.CategoryId = p.CATEGORYID
WHERE p.product = "sportsbook" AND b. BetDate >=  "01/11/2012"
GROUP BY  p.product, b.BetDate
ORDER BY b.BetDate;
-- Question 06:
SELECT c.CustomerGroup,a.CurrencyCode,p.Product,SUM(b.Bet_Amt) AS TotalBetAmt
FROM customer c
JOIN account a
ON c.CustId = a.CustId
JOIN betting b
ON a.AccountNo = b.AccountNo
JOIN product p
ON b.ClassId = p.ClassId
AND b.CategoryId = p.CategoryId
WHERE b.BetDate >= "01/12/2012"
GROUP BY c.CustomerGroup,a.CurrencyCode,p.Product
ORDER BY c.CustomerGroup,a.CurrencyCode,p.Product;

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

-- Question 09:

SELECT 
    b.AccountNo,
    SUM(b.Bet_Amt) AS Total_Bet_Amount
FROM 
    betting AS b
JOIN 
    product AS p ON b.ClassId = p.CLASSID
WHERE 
    p.product = 'Sportsbook'
    AND b.Bet_Amt > 0
GROUP BY 
    b.AccountNo
HAVING 
    COUNT(DISTINCT p.product) = 1;

-- Question 10:
SELECT 
    AccountNo,
    product,
    Total_Staked
FROM (
    SELECT 
        b.AccountNo,
        p.product,
        SUM(b.Bet_Amt) AS Total_Staked,
        ROW_NUMBER() OVER (PARTITION BY b.AccountNo ORDER BY SUM(b.Bet_Amt) DESC) AS rn
    FROM 
        betting AS b
    JOIN 
        product AS p ON b.ClassId = p.CLASSID
    WHERE 
        b.Bet_Amt > 0
    GROUP BY 
        b.AccountNo, p.product
) AS derived
WHERE rn = 1
ORDER BY AccountNo;












