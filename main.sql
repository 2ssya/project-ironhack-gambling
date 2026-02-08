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
