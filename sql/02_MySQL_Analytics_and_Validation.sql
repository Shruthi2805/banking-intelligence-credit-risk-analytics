USE banking_intelligence;
-- 1. Portfolio totals
SELECT COUNT(*) TotalLoans, ROUND(SUM(OriginalPrincipalAED),2) PrincipalAED,
 ROUND(SUM(OutstandingBalanceAED),2) OutstandingAED FROM Loans;
-- 2. Risk rates: delinquency >=30 DPD, nonperforming >=90 DPD (portfolio definitions for this demo)
SELECT COUNT(*) TotalLoans,
 ROUND(100*SUM(DaysPastDue>=30)/NULLIF(COUNT(*),0),2) DelinquencyRatePct,
 ROUND(100*SUM(DaysPastDue>=90)/NULLIF(COUNT(*),0),2) NPLRatePct FROM Loans;
-- 3. Risk by loan type
SELECT LoanType, COUNT(*) LoanCount, ROUND(SUM(OutstandingBalanceAED),2) OutstandingAED,
 SUM(DaysPastDue>=30) DelinquentLoans,
 ROUND(100*SUM(DaysPastDue>=30)/NULLIF(COUNT(*),0),2) DelinquencyPct
 FROM Loans GROUP BY LoanType ORDER BY DelinquencyPct DESC;
-- 4. Branch exposure: join Loans directly to Branches to avoid fanout
SELECT b.BranchName, b.Emirate, COUNT(l.LoanID) LoanCount,
 ROUND(COALESCE(SUM(l.OutstandingBalanceAED),0),2) OutstandingAED,
 COALESCE(SUM(l.DaysPastDue>=30),0) DelinquentLoans
 FROM Branches b LEFT JOIN Loans l ON b.BranchID=l.BranchID
 GROUP BY b.BranchID,b.BranchName,b.Emirate ORDER BY OutstandingAED DESC;
-- 5. Customer segment risk
SELECT c.CustomerSegment, COUNT(DISTINCT c.CustomerID) Customers,
 COUNT(l.LoanID) Loans, ROUND(COALESCE(SUM(l.OutstandingBalanceAED),0),2) OutstandingAED
 FROM Customers c LEFT JOIN Loans l ON c.CustomerID=l.CustomerID
 GROUP BY c.CustomerSegment ORDER BY OutstandingAED DESC;
-- 6. Monthly transaction activity (signed amount retained)
SELECT DATE_FORMAT(TransactionDate,'%Y-%m') TxMonth, COUNT(*) Transactions,
 ROUND(SUM(AmountAED),2) NetAmountAED, SUM(IsFraudFlag=1) FlaggedTransactions
 FROM Transactions GROUP BY DATE_FORMAT(TransactionDate,'%Y-%m') ORDER BY TxMonth;
-- 7. Channel analysis
SELECT Channel,COUNT(*) TxCount,ROUND(SUM(AmountAED),2) NetAmountAED,
 SUM(IsFraudFlag=1) FlaggedTx FROM Transactions GROUP BY Channel ORDER BY TxCount DESC;
-- 8. Data-quality validation
SELECT 'Branches' Dataset, COUNT(*) Records FROM Branches UNION ALL
SELECT 'Customers',COUNT(*) FROM Customers UNION ALL SELECT 'Loans',COUNT(*) FROM Loans
UNION ALL SELECT 'Transactions',COUNT(*) FROM Transactions;
SELECT COUNT(*) InvalidLoanBalances FROM Loans WHERE OutstandingBalanceAED<0;
SELECT COUNT(*) MissingLoanCustomers FROM Loans l LEFT JOIN Customers c ON l.CustomerID=c.CustomerID WHERE c.CustomerID IS NULL;
SELECT COUNT(*) MissingTransactionCustomers FROM Transactions t LEFT JOIN Customers c ON t.CustomerID=c.CustomerID WHERE c.CustomerID IS NULL;
-- Fraud flags are simulated alerts, not confirmed fraudulent activity.
