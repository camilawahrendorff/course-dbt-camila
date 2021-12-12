{{
  config(
    materialized='view'
  )
}}

SELECT 
    e.event_id,
    e.event_type,
    e.session_id,
    e.user_id,
    e.page_url,
    e.created_at,
    o.product_id,
    o.product_name,
    o.product_price,
    o.order_cost,
    o.product_quantity,
    delivered_time


FROM {{ ref('stg_events') }} e
LEFT JOIN {{ ref('fct_orders') }} o USING (user_id)