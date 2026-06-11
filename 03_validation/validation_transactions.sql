--Transaction ETL Validation
SELECT
    s.txn_id                              AS stg_txn_id,
    t.source_transaction_id              AS target_txn_id,

    CASE
        WHEN s.txn_id = t.source_transaction_id
        THEN 'PASS'
        ELSE 'FAIL'
    END AS transaction_id_validation,


    s.units                              AS stg_units,
    t.units                              AS target_units,

    CASE
        WHEN s.units = t.units
        THEN 'PASS'
        ELSE 'FAIL'
    END AS units_validation,


    s.txn_date                           AS stg_txn_date,
    t.transaction_date                   AS target_txn_date,

    CASE
        WHEN s.txn_date = t.transaction_date
        THEN 'PASS'
        ELSE 'FAIL'
    END AS transaction_date_validation,


    s.description                        AS stg_description,
    t.transaction_description            AS target_description,

    CASE
        WHEN s.description = t.transaction_description
        THEN 'PASS'
        ELSE 'FAIL'
    END AS description_validation,


    s.txn_type                           AS stg_transaction_type,
    t.transaction_type                   AS target_transaction_type,

    CASE
        WHEN s.txn_type = 'BUY'
             AND t.transaction_type = 'B'
        THEN 'PASS'

        WHEN s.txn_type = 'SELL'
             AND t.transaction_type = 'S'
        THEN 'PASS'

        WHEN s.txn_type = 'ISSUE'
             AND t.transaction_type = 'I'
        THEN 'PASS'

        WHEN s.txn_type = 'DRP'
             AND t.transaction_type = 'D'
        THEN 'PASS'

        WHEN s.txn_type = 'SPLIT'
             AND t.transaction_type = 'SP'
        THEN 'PASS'

        ELSE 'FAIL'
    END AS transaction_type_validation

FROM stg.transactions s

INNER JOIN target.share_registry_transactions t
    ON s.txn_id = t.source_transaction_id;


--Aggregate validation
SELECT
    (SELECT COUNT(*) FROM stg.transactions) AS stg_transaction_count,

    (SELECT COUNT(*) FROM target.share_registry_transactions)
        AS target_transaction_count,

    (SELECT SUM(units) FROM stg.transactions)
        AS stg_total_units,

    (SELECT SUM(units)
     FROM target.share_registry_transactions)
        AS target_total_units;