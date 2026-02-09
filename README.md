# Medicare Risk Segmentation: 2009 DE-SynPUF Analysis

## Overview
This analysis applies risk segmentation methods to 114,612 Medicare beneficiaries from the 2009 CMS DE-SynPUF dataset to identify cost drivers and segment members by estimated risk.

Using SQL, Excel, and Python, this project serves to showcase my knowledge of common tools used in the actuarial profession.

## Project Workflow
1. **Data Preparation (SQL)**: `Final_Experience_Table.sql`

   Several claims tables were joined to create a single member-level experience file. Using JOINs, GROUP BYs, and VIEWs.
   
2. **Experience Analysis (Excel)**: `Health_Insurance_Experience_Analysis.xlsx`

   Identified and modeled the relationships between member demographics and various utilization metrics.

3. **Risk Modeling (Python)**: `risk_classification.ipynb`

   Created a model to identify cost drivers and segment members by estimated risk.

## Key Findings
- [Finding 1 with visual reference]
- [Finding 2 with visual reference]
- [Finding 3 with visual reference]



## Technical Approach
**Model**: Tweedie GLM (log-link, power=1.5)
**Features**: [List your X variables]
**Validation**: 70/30 train-test split, decile lift analysis

## How to Reproduce
[3-4 steps to run your code]

## Skills Demonstrated
SQL | Python (pandas, sklearn, matplotlib) | Excel | Actuarial analysis

## About
Created as a portfolio project while preparing for entry-level actuarial roles.
[Your LinkedIn/contact]
