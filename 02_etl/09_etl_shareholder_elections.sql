INSERT INTO target.shareholder_ca_elections (
    company_id,
    shareholder_id,
    election_type,
    election_status
)
SELECT
    101 AS company_id,
    
    sh.shareholder_id,
    
    'DRP' AS election_type,
    
    CASE
        WHEN UPPER(s.drp_flag) = 'Y' THEN 'Y'
        ELSE 'N'
    END AS election_status

FROM stg.holder_master s

INNER JOIN target.shareholder_master sh
    ON s.holder_name = sh.shareholder_name;