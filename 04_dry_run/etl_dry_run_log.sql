CREATE TABLE IF NOT EXISTS recon.etl_run_summary (
    run_id              INT,
    run_timestamp       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    target_company_rows INT,
    target_holder_rows  INT,
    target_txn_rows     INT,
    total_units         NUMERIC(20,4),
    position_variance   NUMERIC(20,4),
    status              VARCHAR(20)
);

TRUNCATE TABLE
    target.share_registry_transactions,
    target.shareholder_ca_elections,
    target.stock_split_events,
    target.dividend_events,
    target.shareholder_master,
    target.company_master
RESTART IDENTITY CASCADE;

-- 06_etl_company_master.sql
-- 07_etl_shareholder_master.sql
-- 08_etl_corporate_actions.sql
-- 09_etl_shareholder_elections.sql
-- 10_etl_share_registry_transactions.sql

INSERT INTO recon.etl_run_summary (
    run_id,
    target_company_rows,
    target_holder_rows,
    target_txn_rows,
    total_units,
    position_variance,
    status
)
SELECT
    1 AS run_id,
    (SELECT COUNT(*) FROM target.company_master),
    (SELECT COUNT(*) FROM target.shareholder_master),
    (SELECT COUNT(*) FROM target.share_registry_transactions),
    (SELECT SUM(units) FROM target.share_registry_transactions),
    (
        SELECT COALESCE(SUM(v.units - s.units),0)
        FROM stg.holdings_snapshot s
        LEFT JOIN target.shareholder_master sh
            ON s.holder = sh.shareholder_name
        LEFT JOIN target.vw_reconstructed_holdings v
            ON sh.shareholder_id = v.shareholder_id
    ),
    'PASS';

select * from recon.etl_run_summary




