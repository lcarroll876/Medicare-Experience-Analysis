-- Returns summed inpatient cost and count of inpatient claims for each beneficiary
CREATE VIEW Inpatient_Claims_Summary AS
SELECT 
    DESYNPUF_ID,
    SUM(CLM_PMT_AMT) AS inpatient_cost_2009,
    COUNT(*) AS inpatient_claims_count_2009
FROM Inpatient_Claims
WHERE CLM_THRU_DT BETWEEN 20090101 AND 20091231
GROUP BY DESYNPUF_ID;

-- Returns the count of beneficiaries with inpatient claims in 2009
-- 18794
SELECT COUNT(*) FROM (
    SELECT DESYNPUF_ID
    FROM Inpatient_Claims
    WHERE CLM_THRU_DT BETWEEN 20090101 AND 20091231
    GROUP BY DESYNPUF_ID
);

-- Returns the sum of all inpatient claims in 2009
-- 246789000.0
SELECT SUM(CLM_PMT_AMT)
FROM Inpatient_Claims
WHERE CLM_THRU_DT BETWEEN 20090101 AND 20091231;
