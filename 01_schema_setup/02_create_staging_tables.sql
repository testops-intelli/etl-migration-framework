DROP TABLE IF EXISTS stg.company_data;
CREATE TABLE stg.company_data (
    internal_identifier     BIGINT,
    company_name            TEXT,
    currency                VARCHAR(3),
    ticker                  VARCHAR(20),
    exchange                VARCHAR(20),
    isin                    VARCHAR(20),
    shares_outstanding      NUMERIC(20,0),
    status                  VARCHAR(20),
    listing_date            DATE
);
DROP TABLE IF EXISTS stg.holder_master;
CREATE TABLE stg.holder_master (
    holder_id                  VARCHAR(20),
    holder_type                VARCHAR(50),
    holder_name                TEXT,
    residency_country          VARCHAR(10),
    currency                   VARCHAR(10),
    holder_status              VARCHAR(20),
    drp_flag                   VARCHAR(1),
    holder_reference_type      VARCHAR(10),
    holder_reference_number    VARCHAR(50),
    communication_preference   VARCHAR(20),
    holder_category            VARCHAR(50),
    initial_allocation_flag    VARCHAR(1)
);
DROP TABLE IF EXISTS stg.corporate_actions;
CREATE TABLE stg.corporate_actions (
    action_id              VARCHAR(20),
    action_type            VARCHAR(20),
    ex_date                DATE,
    record_date            DATE,
    payment_date           DATE,
    effective_date         DATE,
    drp_price              NUMERIC(18,4),
    dividend_per_unit      NUMERIC(18,4),
    stock_split_ratio      NUMERIC(18,4)
);
DROP TABLE IF EXISTS stg.transactions;
CREATE TABLE stg.transactions (
    txn_id          VARCHAR(20),
    holder          TEXT,
    txn_type        VARCHAR(20),
    units           NUMERIC(20,4),
    txn_date        DATE,
    description     VARCHAR(100)
);
DROP TABLE IF EXISTS stg.holdings_snapshot;
CREATE TABLE stg.holdings_snapshot (
    holder_id       VARCHAR(20),
    holder           TEXT,
    identifier       VARCHAR(20),
    units            NUMERIC(20,4),
    as_of_date       DATE
);
