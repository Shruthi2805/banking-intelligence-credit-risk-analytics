# Data Dictionary

Synthetic data. Primary keys: Branches.BranchID, Customers.CustomerID, Loans.LoanID, Transactions.TransactionID.

## Branches (6 rows)

| Field | Inferred type |
|---|---|
| BranchID | text |
| BranchName | text |
| Emirate | text |

## Customers (500 rows)

| Field | Inferred type |
|---|---|
| CustomerID | text |
| Age | numeric |
| CustomerSegment | text |
| Occupation | text |
| Emirate | text |
| BranchID | text |
| TenureMonths | numeric |
| AnnualIncomeAED | numeric |
| IsActive | numeric |

## Loans (800 rows)

| Field | Inferred type |
|---|---|
| LoanID | text |
| CustomerID | text |
| BranchID | text |
| LoanType | text |
| OriginationDate | date |
| OriginalPrincipalAED | numeric |
| OutstandingBalanceAED | numeric |
| AnnualInterestRatePct | numeric |
| TermMonths | numeric |
| MonthlyPaymentAED | numeric |
| LoanStatus | text |
| DaysPastDue | numeric |

## Transactions (6000 rows)

| Field | Inferred type |
|---|---|
| TransactionID | text |
| CustomerID | text |
| BranchID | text |
| TransactionDate | date |
| TransactionType | text |
| Category | text |
| AmountAED | numeric |
| Channel | text |
| IsFraudFlag | numeric |

