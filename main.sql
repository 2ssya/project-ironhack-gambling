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





