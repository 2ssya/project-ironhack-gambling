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