# Medicare Experience Analysis

## Overview
This analysis applies risk segmentation methods to 114,612 Medicare beneficiaries from the 2009 CMS DE-SynPUF dataset to identify cost drivers and segment members by estimated risk.

Using SQL, Excel, and Python, this project serves to showcase my knowledge of common tools used in the actuarial profession.

## Project Workflow
1. **Data Preparation (SQL)**: `Final_Experience_Table.sql`

   Several views were created from claims tables, which were then joined to create a single **member-level experience file**.
   <details>
     <summary><b>Click to Expand: Example query</b></summary>

     <p>The following SQL script joins beneficiary demographics with Inpatient, Outpatient, Carrier, and Rx claims VIEWs to create a unified experience VIEW ready for export</p>

      <pre><code>
      -- Creating the final experience view
      CREATE VIEW Final_Experience_View AS
      SELECT
          b.DESYNPUF_ID,
          b.BENE_SEX_IDENT_CD AS sex,
          b.BENE_RACE_CD AS race,
          b.BENE_BIRTH_DT AS birth_date,
         
          CAST((20091231 - b.BENE_BIRTH_DT) / 10000 AS INTEGER) AS age_2009,
      
          COALESCE(ip.inpatient_cost_2009, 0) AS inpatient_cost_2009,
          COALESCE(ip.inpatient_claims_count_2009, 0) AS inpatient_claims_count_2009,
      
          COALESCE(op.outpatient_cost_2009, 0) AS outpatient_cost_2009,
          COALESCE(op.outpatient_claims_count_2009, 0) AS outpatient_claims_count_2009,
      
          COALESCE(car.carrier_cost_2009, 0) AS carrier_cost_2009,
          COALESCE(car.carrier_claims_count_2009, 0) AS carrier_claims_count_2009,
      
          COALESCE(pde.PDE_cost_2009, 0) AS PDE_cost_2009,
          COALESCE(pde.PDE_count_2009, 0) AS PDE_count_2009,
      	
      	COALESCE(ip.inpatient_cost_2009, 0)
      + COALESCE(op.outpatient_cost_2009, 0)
      + COALESCE(car.carrier_cost_2009, 0)
      + COALESCE(pde.PDE_cost_2009, 0)
      AS total_cost_2009
      
      
      FROM Beneficiary_2009 b
      
      LEFT JOIN Inpatient_Claims_Summary ip
      ON b.DESYNPUF_ID = ip.DESYNPUF_ID
      
      LEFT JOIN Outpatient_Claims_Summary op
      ON b.DESYNPUF_ID = op.DESYNPUF_ID
      
      LEFT JOIN Carrier_Claims_Summary car
      ON b.DESYNPUF_ID = car.DESYNPUF_ID
      
      LEFT JOIN PDE_Summary pde
      ON b.DESYNPUF_ID = pde.DESYNPUF_ID;
     </code></pre>
   </details>
   
3. **Experience Analysis (Excel)**: `Health_Insurance_Experience_Analysis.xlsx`

   Identified and modeled the relationships between member demographics and various utilization metrics.
   'Demographic Analysis' sheet shown below as an example.
   
   <img height="300" alt="image" src="https://github.com/user-attachments/assets/5950aec0-a6c3-4f60-8cb9-85fcda11ed95" />


4. **Risk Modeling (Python)**: `risk_classification.ipynb`

   Created a model to identify cost drivers and segment members by estimated risk.

## Key Findings
- Members falling within the 61-80-year age band exhibit lower average costs ($457 PMPM) compared to younger members ($504 - $521 PMPM) *(Attributed to the inflow of healthy age-65 retirees vs. younger disabled members)*
- The top 1% of members account for nearly 11% of the total cost, averaging $5,363 PMPM
- Race/Ethnicity did not serve as a significant cost predictor
- Any Rx use increases estimated cost by a factor of 2.89x, while any inpatient admissions increases estimated cost by a factor of 2.43x
<img height="300" alt="image" src="https://github.com/user-attachments/assets/a8999e78-dae5-4c3a-9feb-2eb4c423d7bf" />
<img height="300" alt="image" src="https://github.com/user-attachments/assets/a799e1dd-9e9c-48e9-a21f-c947375cb0a5" />

## Model Approach
**Model**: Tweedie GLM (log-link, power=1.5)

**Validation**: 70/30 train-test split, decile lift analysis

**Features**:
<table>
  <thead>
    <tr>
      <th>Feature</th>
      <th>Relativity (Impact)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Any Rx Use</b></td>
      <td>2.89</td>
    </tr>
    <tr>
      <td><b>Any Inpatient Stay</b></td>
      <td>2.43</td>
    </tr>
    <tr>
      <td><b>Outpatient (6+ Visits)</b></td>
      <td>1.91</td>
    </tr>
    <tr>
      <td><b>Carrier Band</b></td>
      <td>1.58</td>
    </tr>
    <tr>
      <td><b>Outpatient (3-5 Visits)</b></td>
      <td>1.55</td>
    </tr>
    <tr>
      <td><b>Inpatient Count (Capped)</b></td>
      <td>1.43</td>
    </tr>
    <tr>
      <td><b>Outpatient (1-2 Visits)</b></td>
      <td>1.39</td>
    </tr>
    <tr>
      <td><b>Age 81+</b></td>
      <td>1.31</td>
    </tr>
    <tr>
      <td><b>Age 61-80</b></td>
      <td>1.15</td>
    </tr>
    <tr>
      <td><b>Age 41-60</b></td>
      <td>1.10</td>
    </tr>
    <tr>
      <td><b>Female</b></td>
      <td>1.05</td>
    </tr>
    <tr>
      <td><b>Rx and Age Interaction</b></td>
      <td>0.99</td>
    </tr>
    <tr>
      <td><b>Inpatient and Age 81+ Interaction</b></td>
      <td>0.87</td>
    </tr>
  </tbody>
</table>

Shown below, 'Actual PMPM by Predicted Risk Decile' plots the *actual* average PMPM for the test data, with costs separated based on which cost decile the model estimated it to fall into. As expected, the higher deciles have higher actual average costs. 'Cost Concentration by Predicted Risk' plots the relationship between each decile and the total share of the cost. For example, the plot shows that the top 20% of members account for 60% of the cost.

<img height="300" alt="image" src="https://github.com/user-attachments/assets/aef92e82-62c2-46c8-acdd-85e021dea05a" />
<img height="300" alt="image" src="https://github.com/user-attachments/assets/48486dd8-ec98-4c45-b2da-1988f7af1fe0" />


## About Me
Hello! I am Liam Carroll.

I am an aspiring Actuarial Analyst with a background in Computer Science and software quality assurance.

I have successfully passed SOA Exams P, FM, and SRM within a seven-month period while working full-time. Now, I am seeking an entry-level Actuarial Analyst role where I can apply my technical and analytical abilities to contribute to data-driven decision-making.
