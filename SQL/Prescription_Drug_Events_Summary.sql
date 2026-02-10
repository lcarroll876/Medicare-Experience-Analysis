-- Returns summed PDE cost and count of PDEs for each beneficiary
CREATE VIEW PDE_Summary AS
SELECT 
    DESYNPUF_ID,
    SUM(TOT_RX_CST_AMT) AS PDE_cost_2009,
    COUNT(*) AS PDE_count_2009
FROM Prescription_Drug_Events
WHERE SRVC_DT BETWEEN 20090101 AND 20091231
GROUP BY DESYNPUF_ID;

-- Returns the count of beneficiaries with PDEs in 2009
-- 90500
SELECT COUNT(*) FROM (
    SELECT DESYNPUF_ID
    FROM Prescription_Drug_Events
    WHERE SRVC_DT BETWEEN 20090101 AND 20091231
    GROUP BY DESYNPUF_ID
);

-- Returns the sum of all PDE costs in 2009
-- 133424930.0
SELECT SUM(TOT_RX_CST_AMT)
FROM Prescription_Drug_Events
WHERE SRVC_DT BETWEEN 20090101 AND 20091231;
