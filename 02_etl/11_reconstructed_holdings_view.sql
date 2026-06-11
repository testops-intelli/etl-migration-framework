CREATE OR REPLACE VIEW target.vw_reconstructed_holdings AS

SELECT
    101 AS company_id,
    
    t.shareholder_id,
    
    'AU000000XYZ1' AS identifier,
    
    SUM(t.units) AS units,
    
    DATE '2025-12-31' AS as_of_date

FROM target.share_registry_transactions t

GROUP BY
    t.shareholder_id;