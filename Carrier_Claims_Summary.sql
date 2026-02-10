-- Returns summed carrier cost and count of carrier claims for each beneficiary
CREATE VIEW Carrier_Claims_Summary AS
SELECT
    DESYNPUF_ID,
    SUM(
        LINE_ALOWD_CHRG_AMT_1 +
        LINE_ALOWD_CHRG_AMT_2 +
        LINE_ALOWD_CHRG_AMT_3 +
        LINE_ALOWD_CHRG_AMT_4 +
        LINE_ALOWD_CHRG_AMT_5 +
        LINE_ALOWD_CHRG_AMT_6 +
        LINE_ALOWD_CHRG_AMT_7 +
        LINE_ALOWD_CHRG_AMT_8 +
        LINE_ALOWD_CHRG_AMT_9 +
        LINE_ALOWD_CHRG_AMT_10 +
        LINE_ALOWD_CHRG_AMT_11 +
        LINE_ALOWD_CHRG_AMT_12 +
        LINE_ALOWD_CHRG_AMT_13
    ) AS carrier_cost_2009,
    COUNT(*) AS carrier_claims_count_2009
FROM (
    SELECT * FROM Carrier_Claims_A
    UNION ALL
    SELECT * FROM Carrier_Claims_B
)
WHERE CLM_THRU_DT BETWEEN 20090101 AND 20091231
GROUP BY
    DESYNPUF_ID;
