{{
  config(
    materialized='view'
  )
}}

SELECT 

    order_id,
    product_id,
    quantity
    
FROM {{ ref('order_items_snapshot') }}
WHERE 