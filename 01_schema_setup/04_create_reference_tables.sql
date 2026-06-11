DROP TABLE IF EXISTS ref.currency;
DROP TABLE IF EXISTS ref.country;

CREATE TABLE ref.currency (
    currency_id     SERIAL PRIMARY KEY,
    currency_code   VARCHAR(3)
);

CREATE TABLE ref.country (
    country_id      SERIAL PRIMARY KEY,
    country_code    VARCHAR(10)
);

INSERT INTO ref.currency (currency_code)
SELECT DISTINCT currency
FROM stg.holder_master;

INSERT INTO ref.country (country_code)
SELECT DISTINCT residency_country
FROM stg.holder_master;