/* Banking Intelligence & Risk Analytics
   Demo project - synthetic data only
   Load CSV files into dbo.Customers, dbo.Loans, dbo.Transactions, dbo.Branches first.
*/
-- 1. Portfolio KPIs
SELECT
    COUNT(*) AS TotalLoans,
    SUM(OriginalPrincipalAED) AS TotalOriginalPrincipalAED,
    SUM(OutstandingBalanceAED) AS TotalOutstandingBalanceAED,
    AVG(AnnualInterestRatePct) AS AverageAnnualInterestRatePct
FROM dbo.Loans;

-- 2. Delinquency / at-risk portfolio
SELECT
    LoanStatus,
    COUNT(*) AS LoanCount,
    SUM(OutstandingBalanceAED) AS OutstandingBalanceAED,
    CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS DECIMAL(6,2)) AS PctOfLoans
FROM dbo.Loans
GROUP BY LoanStatus
ORDER BY LoanCount DESC;

-- 3. Risk by loan type
SELECT
    LoanType,
    COUNT(*) AS TotalLoans,
    SUM(CASE WHEN DaysPastDue >= 30 THEN 1 ELSE 0 END) AS DelinquentLoans,
    SUM(CASE WHEN DaysPastDue >= 30 THEN OutstandingBalanceAED ELSE 0 END) AS DelinquentBalanceAED,
    CAST(100.0 * SUM(CASE WHEN DaysPastDue >= 30 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*),0) AS DECIMAL(6,2)) AS DelinquentLoanRatePct
FROM dbo.Loans
GROUP BY LoanType
ORDER BY DelinquentLoanRatePct DESC;

-- 4. Customer segment overview
SELECT
    c.CustomerSegment,
    COUNT(DISTINCT c.CustomerID) AS Customers,
    AVG(CAST(c.AnnualIncomeAED AS DECIMAL(18,2))) AS AvgAnnualIncomeAED,
    COUNT(l.LoanID) AS LoanCount,
    SUM(l.OutstandingBalanceAED) AS OutstandingBalanceAED
FROM dbo.Customers c
LEFT JOIN dbo.Loans l ON c.CustomerID = l.CustomerID
GROUP BY c.CustomerSegment
ORDER BY OutstandingBalanceAED DESC;

-- 5. Branch performance
SELECT
    b.Emirate,
    b.BranchName,
    COUNT(DISTINCT c.CustomerID) AS Customers,
    COUNT(DISTINCT l.LoanID) AS Loans,
    SUM(l.OutstandingBalanceAED) AS OutstandingBalanceAED,
    SUM(CASE WHEN l.DaysPastDue >= 30 THEN l.OutstandingBalanceAED ELSE 0 END) AS DelinquentBalanceAED
FROM dbo.Branches b
LEFT JOIN dbo.Customers c ON b.BranchID = c.BranchID
LEFT JOIN dbo.Loans l ON c.CustomerID = l.CustomerID
GROUP BY b.Emirate, b.BranchName
ORDER BY OutstandingBalanceAED DESC;

-- 6. Monthly transaction trends
SELECT
    DATEFROMPARTS(YEAR(TransactionDate), MONTH(TransactionDate), 1) AS TransactionMonth,
    TransactionType,
    COUNT(*) AS TransactionCount,
    SUM(AmountAED) AS NetTransactionAmountAED,
    SUM(CASE WHEN IsFraudFlag = 1 THEN 1 ELSE 0 END) AS FlaggedTransactionCount
FROM dbo.Transactions
GROUP BY DATEFROMPARTS(YEAR(TransactionDate), MONTH(TransactionDate), 1), TransactionType
ORDER BY TransactionMonth, TransactionType;

-- 7. Flagged transactions for review (flag is synthetic and not proof of fraud)
SELECT TransactionID, CustomerID, TransactionDate, Category, AmountAED, Channel
FROM dbo.Transactions
WHERE IsFraudFlag = 1
ORDER BY TransactionDate DESC;

-- 8. Data quality checks
SELECT CustomerID, COUNT(*) AS RowCount
FROM dbo.Customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;

SELECT LoanID, COUNT(*) AS RowCount
FROM dbo.Loans
GROUP BY LoanID
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS InvalidNegativeBalances
FROM dbo.Loans
WHERE OutstandingBalanceAED < 0;
