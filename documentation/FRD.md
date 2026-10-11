# Functional Requirements Document (FRD)

**Project:** Banking Intelligence & Risk Analytics | **Data:** synthetic

## Functional requirements
| ID | Requirement | Acceptance criterion |
|---|---|---|
| FR-01 | Executive KPIs for customers, loans, principal, outstanding and transactions | Cards reconcile with source records |
| FR-02 | Credit risk page with delinquency and NPL metrics | >=30 DPD and >=90 DPD definitions are disclosed and verified |
| FR-03 | Risk analysis by loan type and branch | Counts and exposure reconcile with SQL grouped results |
| FR-04 | Customer and branch intelligence | Branch filters update relevant visuals |
| FR-05 | Drill-through from branch-level risk to branch intelligence | Selected branch context passes to destination page |
| FR-06 | Data-quality monitoring | Duplicate IDs, invalid balances, orphaned keys are checked |
| FR-07 | Report usability | Titles, units (AED), slicers, and navigation are legible |

## Non-functional requirements
NFR-01: Use synthetic data only. NFR-02: No personal bank customer data. NFR-03: Clearly label metrics and units. NFR-04: Refresh without schema errors.

## Dependencies and assumptions
CSV columns must match the data dictionary; MySQL 8 and Power BI Desktop are used. This document describes intended behavior; execution must be verified in the actual report.
