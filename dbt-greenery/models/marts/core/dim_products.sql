{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id,
    name,
    CASE WHEN quantity > 0 THEN 'out_of_stock' ELSE 'in_stock' END AS in_stock,
    quantity 

FROM {{ ref('stg_products') }}