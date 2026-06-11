--Aggregate decomposition
SELECT
    (SELECT COUNT(*)
     FROM stg.corporate_actions
     WHERE UPPER(action_type) = 'DIVIDEND') AS stg_dividend_count,
	 
    (SELECT COUNT(*)
     FROM target.dividend_events) AS target_dividend_count,

    (SELECT COUNT(*)
     FROM stg.corporate_actions
     WHERE UPPER(action_type) = 'SPLIT') AS stg_split_count,

    (SELECT COUNT(*)
     FROM target.stock_split_events) AS target_split_count;


--Dividend transformation validation
SELECT
    s.action_id,
    
    d.dividend_code,
    
    CASE
        WHEN d.dividend_code = 'D_' || s.action_id
        THEN 'PASS'
        ELSE 'FAIL'
    END AS dividend_code_validation,

    s.dividend_per_unit,
    d.dividend_per_unit,

    CASE
        WHEN s.dividend_per_unit = d.dividend_per_unit
        THEN 'PASS'
        ELSE 'FAIL'
    END AS dividend_amount_validation,

    s.drp_price,
    d.drp_price,

    CASE
        WHEN s.drp_price = d.drp_price
        THEN 'PASS'
        ELSE 'FAIL'
    END AS drp_price_validation

FROM stg.corporate_actions s

INNER JOIN target.dividend_events d
    ON d.dividend_code = 'D_' || s.action_id

WHERE UPPER(s.action_type) = 'DIVIDEND';

--Stock split validation
SELECT
    s.action_id,
    
    sp.split_code,

    CASE
        WHEN sp.split_code = 'S_' || s.action_id
        THEN 'PASS'
        ELSE 'FAIL'
    END AS split_code_validation,

    s.stock_split_ratio,
    sp.split_ratio,

    CASE
        WHEN s.stock_split_ratio = sp.split_ratio
        THEN 'PASS'
        ELSE 'FAIL'
    END AS split_ratio_validation

FROM stg.corporate_actions s

INNER JOIN target.stock_split_events sp
    ON sp.split_code = 'S_' || s.action_id

WHERE UPPER(s.action_type) = 'SPLIT';

--DRP elections validation
SELECT
    (SELECT COUNT(*)
     FROM stg.holder_master
     WHERE UPPER(drp_flag) = 'Y') AS stg_drp_yes_count,

    (SELECT COUNT(*)
     FROM target.shareholder_ca_elections
     WHERE election_type = 'DRP'
       AND election_status = 'Y') AS target_drp_yes_count;
