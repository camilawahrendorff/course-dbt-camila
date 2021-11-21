{{
  config(
    materialized='view',
    unique_key='dbt_scd_id'
  )
}}

SELECT 
    product_id,
    name,
    price,
    quantity as stock,
    dbt_scd_id,
    dbt_updated_at,
    dbt_valid_from,
    dbt_valid_to

FROM {{ ref('products_snapshot') }}