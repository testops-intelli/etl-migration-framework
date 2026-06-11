SELECT
    s.company_name                         AS stg_company_name,
    t.company_name                         AS target_company_name,
    
    CASE
        WHEN s.company_name = t.company_name
        THEN 'PASS'
        ELSE 'FAIL'
    END AS company_name_validation,


    s.ticker                               AS stg_ticker,
    t.ticker                               AS target_ticker,

    CASE
        WHEN s.ticker = t.ticker
        THEN 'PASS'
        ELSE 'FAIL'
    END AS ticker_validation,


    s.exchange                             AS stg_exchange,
    t.exchange_code                        AS target_exchange,

    CASE
        WHEN s.exchange = t.exchange_code
        THEN 'PASS'
        ELSE 'FAIL'
    END AS exchange_validation,


    s.isin                                 AS stg_isin,
    t.isin                                 AS target_isin,

    CASE
        WHEN s.isin = t.isin
        THEN 'PASS'
        ELSE 'FAIL'
    END AS isin_validation,


    s.shares_outstanding                   AS stg_shares_outstanding,
    t.shares_outstanding                   AS target_shares_outstanding,

    CASE
        WHEN s.shares_outstanding = t.shares_outstanding
        THEN 'PASS'
        ELSE 'FAIL'
    END AS shares_validation,


    s.status                               AS stg_status,
    t.company_status                       AS target_status,

    CASE
        WHEN UPPER(s.status) = 'ACTIVE'
             AND t.company_status = 'A'
        THEN 'PASS'
        ELSE 'FAIL'
    END AS status_mapping_validation,


    s.currency                             AS stg_currency,
    rc.currency_code                       AS target_currency,

    CASE
        WHEN s.currency = rc.currency_code
        THEN 'PASS'
        ELSE 'FAIL'
    END AS currency_validation,


    s.listing_date                         AS stg_listing_date,
    t.listing_date                         AS target_listing_date,

    CASE
        WHEN s.listing_date = t.listing_date
        THEN 'PASS'
        ELSE 'FAIL'
    END AS listing_date_validation

FROM stg.company_data s

INNER JOIN target.company_master t
    ON s.isin = t.isin

LEFT JOIN ref.currency rc
    ON t.currency_id = rc.currency_id;