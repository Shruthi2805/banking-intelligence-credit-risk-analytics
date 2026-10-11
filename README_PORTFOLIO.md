# Banking Intelligence & Credit Risk | Portfolio Package

**Synthetic educational case study.** Source CSVs and workbook are in `data/`.

## Contents
- `sql/01_MySQL_Schema.sql`: MySQL 8 schema.
- `sql/02_MySQL_Analytics_and_Validation.sql`: analysis and QA queries.
- `sql/Banking_Analytics_Queries.sql`: original starter script (SQL Server dialect; do not run in MySQL).
- `documentation/`: original BRD plus FRD, UAT cases, Jira stories, data dictionary, insights.
- `powerbi/`: dashboard build guide. Your actual `.pbix` file is **not included**; add it once saved from Power BI Desktop.

## MySQL setup
1. Open Workbench and connect to MySQL 8.
2. Execute `sql/01_MySQL_Schema.sql`.
3. Import CSV files in order: Branches, Customers, Loans, Transactions, using Workbench Table Data Import Wizard into **existing tables**. Ensure imported date fields are DATE and decimal fields are numeric.
4. Run `sql/02_MySQL_Analytics_and_Validation.sql`; reconcile with Power BI and complete UAT.

## Suggested Confluence pages
Project overview, BRD, FRD, Data Dictionary, UAT, Insights & Recommendations. Paste corresponding documentation into pages.

## Jira
Use epics and stories from `documentation/Jira_User_Stories.md`.

## Important
Do not claim UAT passed before testing. Do not publish this as a real bank's data.
