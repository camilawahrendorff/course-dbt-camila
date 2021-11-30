{{
  config(
    materialized='view',
  )
}}

SELECT 
    user_id,
    address_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    dbt_updated_at as updated_at,
    dbt_valid_from as valid_from,
    dbt_valid_to as valid_to

FROM {{ ref('users_snapshot') }}