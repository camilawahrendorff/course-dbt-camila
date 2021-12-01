{{
  config(
    materialized='table'
  )
}}

SELECT 
    p,product_id,
    p.name,
    CASE WHEN quantity > 0 THEN 'out_of_stock' ELSE 'in_stock' END AS in_stock,
    p.quantity

FROM {{ ref('stg_products') }} as p