INSERT INTO target.share_registry_transactions (
    company_id,
    shareholder_id,
    source_transaction_id,
    transaction_type,
    units,
    transaction_date,
    transaction_description
)
SELECT
    101 AS company_id,
    
    sh.shareholder_id,
    
    s.txn_id AS source_transaction_id,
    
    CASE
        WHEN UPPER(s.txn_type) = 'BUY' THEN 'B'
        WHEN UPPER(s.txn_type) = 'SELL' THEN 'S'
        WHEN UPPER(s.txn_type) = 'ISSUE' THEN 'I'
        WHEN UPPER(s.txn_type) = 'DRP' THEN 'D'
        WHEN UPPER(s.txn_type) = 'SPLIT' THEN 'SP'
        ELSE 'U'
    END AS transaction_type,
    
    s.units,
    
    s.txn_date,
    
    s.description

FROM stg.transactions s

INNER JOIN target.shareholder_master sh
    ON s.holder = sh.shareholder_name;