--Aggregate validation
SELECT
    (SELECT COUNT(*) FROM stg.holder_master) AS stg_holder_count,
    (SELECT COUNT(*) FROM target.shareholder_master) AS target_holder_count,  
    (
        SELECT COUNT(*)
        FROM stg.holder_master s
        INNER JOIN target.shareholder_master t
            ON s.holder_name = t.shareholder_name
    ) AS matched_holder_count;

--Row level reconciliation
SELECT
    s.holder_name,
    t.shareholder_name,

    CASE
        WHEN s.holder_name = t.shareholder_name
        THEN 'PASS'
        ELSE 'FAIL'
    END AS holder_name_validation,


    s.holder_type,
    t.shareholder_type,

    CASE
        WHEN s.holder_type = 'INDIVIDUAL'
             AND t.shareholder_type = 'I'
        THEN 'PASS'

        WHEN s.holder_type = 'TRUST'
             AND t.shareholder_type = 'T'
        THEN 'PASS'

        WHEN s.holder_type = 'FUND'
             AND t.shareholder_type = 'F'
        THEN 'PASS'
        
		WHEN s.holder_type = 'JOINT'
     		 AND t.shareholder_type = 'J'
		THEN 'PASS'

		WHEN s.holder_type = 'SMSF'
             AND t.shareholder_type = 'U'
		THEN 'PASS' 
		
		ELSE 'FAIL'
    END AS holder_type_validation,


    s.holder_status,
    t.shareholder_status,

    CASE
        WHEN s.holder_status = 'ACTIVE'
             AND t.shareholder_status = 'A'
        THEN 'PASS'

        WHEN s.holder_status = 'CLOSED'
             AND t.shareholder_status = 'C'
        THEN 'PASS'

        WHEN s.holder_status = 'SUSPENDED'
             AND t.shareholder_status = 'S'
        THEN 'PASS'

        WHEN s.holder_status = 'DECEASED'
             AND t.shareholder_status = 'D'
        THEN 'PASS'

        WHEN s.holder_status = 'DORMANT'
             AND t.shareholder_status = 'O'
        THEN 'PASS'

        ELSE 'FAIL'
    END AS holder_status_validation,


    s.currency,
    rc.currency_code,

    CASE
        WHEN s.currency = rc.currency_code
        THEN 'PASS'
        ELSE 'FAIL'
    END AS currency_validation,


    s.residency_country,
    rco.country_code,

    CASE
        WHEN s.residency_country = rco.country_code
        THEN 'PASS'
        ELSE 'FAIL'
    END AS country_validation

FROM stg.holder_master s

INNER JOIN target.shareholder_master t
    ON s.holder_name = t.shareholder_name

LEFT JOIN ref.currency rc
    ON t.currency_id = rc.currency_id

LEFT JOIN ref.country rco
    ON t.residency_country_id = rco.country_id;