
   
{{
  config(
    materialized='view'
  )
}}

SELECT 

    promo_id,
    discout as discount,
    dbt_scd_id,
    dbt_updated_at as updated_at,
    dbt_valid_from as valid_from,
    dbt_valid_to as valid_to

FROM {{ref('promos_snapshot')}}