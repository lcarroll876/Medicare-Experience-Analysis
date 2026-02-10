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
