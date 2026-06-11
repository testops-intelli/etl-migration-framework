DROP TABLE IF EXISTS target.stock_split_events;
DROP TABLE IF EXISTS target.dividend_events;
DROP TABLE IF EXISTS target.shareholder_ca_elections;
DROP TABLE IF EXISTS target.shareholder_master;
DROP TABLE IF EXISTS target.company_master;

CREATE TABLE target.company_master (
    company_id             BIGSERIAL PRIMARY KEY,
    company_name           TEXT,
    ticker                 VARCHAR(20),
    exchange_code          VARCHAR(20),
    isin                   VARCHAR(20),
    sedol                  VARCHAR(20),
    currency_id            INT,
    shares_outstanding     NUMERIC(20,0),
    company_status         VARCHAR(1),
    listing_date           DATE
);

CREATE TABLE target.shareholder_master (
    shareholder_id                 BIGSERIAL PRIMARY KEY,
    company_id                     BIGINT,
    shareholder_name               TEXT,
    shareholder_type               VARCHAR(1),
    residency_country_id           INT,
    currency_id                    INT,
    shareholder_status             VARCHAR(1),
    holder_reference_type          VARCHAR(10),
    holder_reference_number        VARCHAR(50),
    communication_preference       VARCHAR(1),
    holder_category                VARCHAR(1)
);

CREATE TABLE target.shareholder_ca_elections (
    election_id            BIGSERIAL PRIMARY KEY,
    company_id             BIGINT,
    shareholder_id         BIGINT,
    election_type          VARCHAR(20),
    election_status        VARCHAR(1)
);

CREATE TABLE target.dividend_events (
    dividend_event_id          BIGSERIAL PRIMARY KEY,
    company_id                 BIGINT,
    dividend_code              VARCHAR(20),
    ex_date                    DATE,
    record_date                DATE,
    payment_date               DATE,
    effective_date             DATE,
    drp_price                  NUMERIC(18,4),
    dividend_per_unit          NUMERIC(18,4)
);

CREATE TABLE target.stock_split_events (
    stock_split_event_id       BIGSERIAL PRIMARY KEY,
    company_id                 BIGINT,
    split_code                 VARCHAR(20),
    ex_date                    DATE,
    record_date                DATE,
    effective_date             DATE,
    split_ratio                NUMERIC(18,4)
);

CREATE TABLE target.share_registry_transactions (
    transaction_id            BIGSERIAL PRIMARY KEY,
    company_id                BIGINT,
    shareholder_id            BIGINT,
    source_transaction_id     VARCHAR(20),
    transaction_type          VARCHAR(10),
    units                     NUMERIC(20,4),
    transaction_date          DATE,
    transaction_description   VARCHAR(100)
);