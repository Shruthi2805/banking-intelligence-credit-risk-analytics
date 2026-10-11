# Data-backed observations (synthetic data)

Source CSV totals (before any Power BI filters):

- Customers: **500**; loans: **800**; branches: **6**; transactions: **6,000**.
- Original loan principal: **AED 282,972,315.00**; outstanding balance: **AED 149,323,921.65**.
- Net sum of transaction AmountAED: **AED 17,364,244.33**.
- Loans at >=30 days past due: **117** (14.62% of loans).
- Loans at >=90 days past due: **20** (2.50% of loans).
- Simulated fraud-flagged transactions: **54**. Flags do not establish actual fraud.

## Recommendations for a case-study presentation
- Track delinquency by branch and loan type, then prioritize review of higher-risk segments.
- Reconcile monthly transaction counts and signed net values before interpreting volume as revenue.
- Validate risk-rate definitions with stakeholders: DPD-based definitions are portfolio conventions for this demonstration.

**Caution:** These are synthetic-data observations, not actual bank findings. Power BI measures may differ if filters or alternative definitions are applied.
