-- Returns summed outpatient cost and count of outpatient claims for each beneficiary
CREATE VIEW Outpatient_Claims_Summary AS
SELECT 
    DESYNPUF_ID,
    SUM(CLM_PMT_AMT) AS outpatient_cost_2009,
    COUNT(*) AS outpatient_claims_count_2009
FROM Outpatient_Claims
WHERE CLM_THRU_DT BETWEEN 20090101 AND 20091231
GROUP BY DESYNPUF_ID;

-- Returns the count of beneficiaries with outpatient claims in 2009
-- 71873
SELECT COUNT(*) FROM (
    SELECT DESYNPUF_ID
    FROM Outpatient_Claims
    WHERE CLM_THRU_DT BETWEEN 20090101 AND 20091231
    GROUP BY DESYNPUF_ID
);

-- Returns the sum of all outpatient claims in 2009
-- 88210930.0
SELECT SUM(CLM_PMT_AMT)
FROM Outpatient_Claims
WHERE CLM_THRU_DT BETWEEN 20090101 AND 20091231;