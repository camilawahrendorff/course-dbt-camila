
   
{{
  config(
    materialized='view',
    unique_key='dbt_scd_id'
  )
}}

SELECT 

    promo_id,
    discout as discount,
    dbt_scd_id,
    dbt_updated_at,
    dbt_valid_from,
    dbt_valid_to

FROM {{ref('promos_snapshot')}}