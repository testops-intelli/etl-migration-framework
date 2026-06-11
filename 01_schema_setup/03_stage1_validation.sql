-- Row Count Validation
SELECT COUNT(*) AS company_data_count
FROM stg.company_data;

SELECT COUNT(*) AS holder_master_count
FROM stg.holder_master;

SELECT COUNT(*) AS corporate_actions_count
FROM stg.corporate_actions;

SELECT COUNT(*) AS transactions_count
FROM stg.transactions;

-- Aggregate Validation
SELECT
    SUM(units) AS total_transaction_units
FROM stg.transactions;


-- Distinct Holder Validation
SELECT
    COUNT(DISTINCT holder) AS distinct_holder_count
FROM stg.transactions;


-- Null Validation
SELECT
    COUNT(*) AS null_txn_id_count
FROM stg.transactions
WHERE txn_id IS NULL;

SELECT
    COUNT(*) AS null_holder_count
FROM stg.transactions
WHERE holder IS NULL;

-- Duplicate Transaction Validation
SELECT
    txn_id,
    COUNT(*) AS duplicate_count
FROM stg.transactions
GROUP BY txn_id
HAVING COUNT(*) > 1;

-- Shares Issued Reconciliation
SELECT 
    SUM(t.units) AS reconstructed_units,
    c.shares_outstanding,
    SUM(t.units) - c.shares_outstanding AS variance
FROM stg.company_data c
CROSS JOIN stg.transactions t
GROUP BY c.shares_outstanding;

SELECT
    COUNT(*) AS orphan_transaction_holders
FROM stg.transactions t
LEFT JOIN stg.holder_master h
    ON t.holder = h.holder_name
WHERE h.holder_name IS NULL;

SELECT COUNT(*) AS holdings_snapshot_count
FROM stg.holdings_snapshot;


