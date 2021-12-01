{{
  config(
    materialized='table'
  )
}}

SELECT 
    o.order_id,
    u.user_id,
    u.first_name,
    u.last_name,
    o.status,
    o.estimated_delivery_at,
    o.created_at,
    o.delivered_at,
    o.order_cost,
    o.shipping_cost,
    o.order_total,
    o.product_id
FROM {{ ref('fct_orders') }} as o
LEFT JOIN {{ ref('dim_users') }} as u USING (user_id)