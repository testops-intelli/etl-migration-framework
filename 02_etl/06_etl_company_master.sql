INSERT INTO target.company_master (
    company_name,
    ticker,
    exchange_code,
    isin,
    sedol,
    currency_id,
    shares_outstanding,
    company_status,
    listing_date
)
SELECT
    s.company_name,
    s.ticker,
    s.exchange,
    s.isin,
    NULL AS sedol,
    
    c.currency_id,
    
    s.shares_outstanding,
    
    CASE
        WHEN UPPER(s.status) = 'ACTIVE' THEN 'A'
        ELSE 'I'
    END AS company_status,
    
    s.listing_date

FROM stg.company_data s

LEFT JOIN ref.currency c
    ON s.currency = c.currency_code;