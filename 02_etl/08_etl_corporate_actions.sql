-- Dividend Events ETL

INSERT INTO target.dividend_events (
    company_id,
    dividend_code,
    ex_date,
    record_date,
    payment_date,
    effective_date,
    drp_price,
    dividend_per_unit
)
SELECT
    101 AS company_id,
    
    'D_' || s.action_id AS dividend_code,
    
    s.ex_date,
    s.record_date,
    s.payment_date,
    s.effective_date,
    
    s.drp_price,
    
    s.dividend_per_unit

FROM stg.corporate_actions s

WHERE UPPER(s.action_type) = 'DIVIDEND';



-- Stock Split Events ETL

INSERT INTO target.stock_split_events (
    company_id,
    split_code,
    ex_date,
    record_date,
    effective_date,
    split_ratio
)
SELECT
    101 AS company_id,
    
    'S_' || s.action_id AS split_code,
    
    s.ex_date,
    s.record_date,
    s.effective_date,
    
    s.stock_split_ratio

FROM stg.corporate_actions s

WHERE UPPER(s.action_type) = 'SPLIT';