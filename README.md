# Banking Intelligence & Risk Analytics

## What this is
A ready-to-use, synthetic-data portfolio project for a Business Analyst / BI Analyst candidate. It includes source data, SQL analysis, a project brief/BRD, UAT scenarios, and a Power BI dashboard build guide.

## Files
- `data/Banking_Project_Data.xlsx`: workbook with Customers, Loans, Transactions, Branches.
- `data/*.csv`: individual source tables for Power Query or SQL import.
- `sql/Banking_Analytics_Queries.sql`: starter SQL analysis and data-quality checks.
- `documentation/Banking_Project_Brief_and_BRD.docx`: problem statement, objectives, requirements, KPIs, data model, UAT and risks.
- `powerbi/PowerBI_Dashboard_Build_Guide.docx`: suggested pages, visuals, and starter DAX measures.

## Suggested Power BI model
- Customers[CustomerID] -> Loans[CustomerID] (one-to-many)
- Customers[CustomerID] -> Transactions[CustomerID] (one-to-many)
- Branches[BranchID] -> Customers[BranchID] (one-to-many)

Avoid creating multiple active relationship paths that cause ambiguous filtering. The BranchID columns in Loans and Transactions are redundant convenience fields; do not create extra active Branches-to-fact relationships if they cause ambiguity.

## Suggested workflow
1. Review the BRD and business questions.
2. Load Excel tables into Power BI.
3. Use Power Query to check types, nulls, duplicates and invalid values.
4. Create relationships and starter DAX measures from the build guide.
5. Build three report pages: Executive Overview, Credit Risk, Customer & Transactions.
6. Validate totals against the source data and complete UAT.
7. Write a short executive summary using observed results from your final report.

## Important limitations
- All data is synthetic and intended only for learning/portfolio demonstration.
- `IsFraudFlag` is simulated and indicates a record for review, not confirmed fraud.
- Loan balances and monthly payments are illustrative, not a financial amortization model.
- Do not present synthetic results as real bank performance.
