INSERT INTO target.shareholder_master (
    company_id,
    shareholder_name,
    shareholder_type,
    residency_country_id,
    currency_id,
    shareholder_status,
    holder_reference_type,
    holder_reference_number,
    communication_preference,
    holder_category
)
SELECT
    101 AS company_id,
    
    s.holder_name,
    
    CASE
        WHEN UPPER(s.holder_type) = 'INDIVIDUAL' THEN 'I'
        WHEN UPPER(s.holder_type) = 'FUND' THEN 'F'
        WHEN UPPER(s.holder_type) = 'TRUST' THEN 'T'
        WHEN UPPER(s.holder_type) = 'SUPER' THEN 'S'
        WHEN UPPER(s.holder_type) = 'JOINT' THEN 'J'
        ELSE 'U'
    END AS shareholder_type,
    
    ctry.country_id,
    
    cur.currency_id,
    
    CASE
        WHEN UPPER(s.holder_status) = 'ACTIVE' THEN 'A'
        WHEN UPPER(s.holder_status) = 'CLOSED' THEN 'C'
        WHEN UPPER(s.holder_status) = 'SUSPENDED' THEN 'S'
        WHEN UPPER(s.holder_status) = 'DECEASED' THEN 'D'
        WHEN UPPER(s.holder_status) = 'DORMANT' THEN 'O'
        ELSE 'U'
    END AS shareholder_status,
    
    s.holder_reference_type,
    
    s.holder_reference_number,
    
    CASE
        WHEN UPPER(s.communication_preference) = 'EMAIL' THEN 'E'
        WHEN UPPER(s.communication_preference) = 'POST' THEN 'P'
        ELSE 'U'
    END AS communication_preference,
    
    CASE
        WHEN UPPER(s.holder_category) = 'RETAIL' THEN 'R'
        WHEN UPPER(s.holder_category) = 'INSTITUTIONAL' THEN 'I'
        WHEN UPPER(s.holder_category) = 'FOUNDER' THEN 'F'
        ELSE 'U'
    END AS holder_category

FROM stg.holder_master s

LEFT JOIN ref.country ctry
    ON s.residency_country = ctry.country_code

LEFT JOIN ref.currency cur
    ON s.currency = cur.currency_code;