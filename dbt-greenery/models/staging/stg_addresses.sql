{{
  config(
    materialized='view'
  )
}}

SELECT 
    address_id,
    address,
    zipcode,
    state,
    country,
    dbt_updated_at as updated_at,
    dbt_valid_from as valid_from,
    dbt_valid_to as valid_to

FROM {{ ref('addresses_snapshot') }}
