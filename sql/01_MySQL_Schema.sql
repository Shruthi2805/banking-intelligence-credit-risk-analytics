-- MySQL 8.0 | Banking Intelligence & Risk Analytics | synthetic portfolio data
-- Run this script first in MySQL Workbench; then import four CSVs using Table Data Import Wizard.
CREATE DATABASE IF NOT EXISTS banking_intelligence CHARACTER SET utf8mb4;
USE banking_intelligence;

CREATE TABLE IF NOT EXISTS Branches (
 BranchID VARCHAR(12) PRIMARY KEY, BranchName VARCHAR(120), Emirate VARCHAR(80));
CREATE TABLE IF NOT EXISTS Customers (
 CustomerID VARCHAR(12) PRIMARY KEY, Age INT, CustomerSegment VARCHAR(60), Occupation VARCHAR(100),
 Emirate VARCHAR(80), BranchID VARCHAR(12), TenureMonths INT, AnnualIncomeAED DECIMAL(18,2), IsActive TINYINT,
 CONSTRAINT fk_customers_branch FOREIGN KEY (BranchID) REFERENCES Branches(BranchID));
CREATE TABLE IF NOT EXISTS Loans (
 LoanID VARCHAR(12) PRIMARY KEY, CustomerID VARCHAR(12), BranchID VARCHAR(12), LoanType VARCHAR(60),
 OriginationDate DATE, OriginalPrincipalAED DECIMAL(18,2), OutstandingBalanceAED DECIMAL(18,2),
 AnnualInterestRatePct DECIMAL(8,3), TermMonths INT, MonthlyPaymentAED DECIMAL(18,2),
 LoanStatus VARCHAR(80), DaysPastDue INT,
 CONSTRAINT fk_loans_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
 CONSTRAINT fk_loans_branch FOREIGN KEY (BranchID) REFERENCES Branches(BranchID));
CREATE TABLE IF NOT EXISTS Transactions (
 TransactionID VARCHAR(12) PRIMARY KEY, CustomerID VARCHAR(12), BranchID VARCHAR(12), TransactionDate DATE,
 TransactionType VARCHAR(60), Category VARCHAR(100), AmountAED DECIMAL(18,2), Channel VARCHAR(80), IsFraudFlag TINYINT,
 CONSTRAINT fk_transactions_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
 CONSTRAINT fk_transactions_branch FOREIGN KEY (BranchID) REFERENCES Branches(BranchID));
-- Import order: Branches -> Customers -> Loans -> Transactions. Skip table creation in import wizard.
