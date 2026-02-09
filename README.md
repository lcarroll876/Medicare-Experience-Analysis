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
- Members falling within the 61-80-year age band exhibit lower average costs ($457 PMPM) compared to younger members ($504 - $521 PMPM)
- The top 1% of members account for nearly 11% of the total cost, averaging $5,363 PMPM
- Race/Ethnicity did not serve as a significant cost predictor
- Any Rx use increases estimated cost by a factor of 2.89x, while any inpatient admissions increases estimated cost by a factor of 2.43x
<img height="300" alt="image" src="https://github.com/user-attachments/assets/a8999e78-dae5-4c3a-9feb-2eb4c423d7bf" />
<img height="300" alt="image" src="https://github.com/user-attachments/assets/a799e1dd-9e9c-48e9-a21f-c947375cb0a5" />

## Technical Approach
**Model**: Tweedie GLM (log-link, power=1.5)

**Validation**: 70/30 train-test split, decile lift analysis

**Features**:
- any_rx_2009
- any_inpatient_2009
- carrier_band
- op_band
- ip_count_capped
- op_band
- age_band
- female
- rx_x_age
- ip_x_81plus


