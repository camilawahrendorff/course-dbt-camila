{{
  config(
    materialized='view'
  )
}}

  SELECT 
    order_id,
    user_id,
    promo_id,
    address_id,
    tracking_id,
    shipping_service,
    status,
    estimated_delivery_at,
    created_at,
    delivered_at,
    order_cost,
    shipping_cost,
    order_total
    
FROM {{ source('greenery_db', 'orders') }}