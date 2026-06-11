
-- Holdings reconciliation
SELECT
    s.holder_id                         AS stg_holder_id,
    
    s.holder                            AS stg_holder_name,
    
    sh.shareholder_name                 AS target_holder_name,


    s.identifier                        AS stg_identifier,
    
    v.identifier                        AS reconstructed_identifier,


    s.units                             AS stg_units,
    
    v.units                             AS reconstructed_units,


    v.units - s.units                   AS variance,


    CASE
        WHEN v.units = s.units
        THEN 'PASS'
        ELSE 'FAIL'
    END AS units_validation,

    s.as_of_date                        AS stg_as_of_date,  
    v.as_of_date                        AS reconstructed_as_of_date,

    CASE
        WHEN s.as_of_date = v.as_of_date
        THEN 'PASS'
        ELSE 'FAIL'
    END AS as_of_date_validation

FROM stg.holdings_snapshot s

LEFT JOIN target.shareholder_master sh
    ON s.holder = sh.shareholder_name

LEFT JOIN target.vw_reconstructed_holdings v
    ON sh.shareholder_id = v.shareholder_id

ORDER BY ABS(v.units - s.units) DESC;

--Summary validation
SELECT
    COUNT(*) AS total_positions,

    SUM(
        CASE
            WHEN v.units = s.units
            THEN 1
            ELSE 0
        END
    ) AS matched_positions,

    SUM(v.units - s.units) AS total_variance

FROM stg.holdings_snapshot s

LEFT JOIN target.shareholder_master sh
    ON s.holder = sh.shareholder_name

LEFT JOIN target.vw_reconstructed_holdings v
    ON sh.shareholder_id = v.shareholder_id;

