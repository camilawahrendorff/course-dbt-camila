{{
  config(
    materialized='table'
  )
}}

SELECT distinct
    b.order_id,
    b.user_id,
    b.promo_id,
    b.address_id,
    b.tracking_id,
    b.shipping_service,
    b.status,
    b.estimated_delivery_at,
    b.created_at,
    b.delivered_at,
    b.order_cost,
    b.shipping_cost,
    b.order_total,
    i.product_id,
    i.quantity,
    {{ dbt_utils.datediff("created_at", "delivered_at", 'day') }} as delivered_time,
    p.name as product_name,
    p.price as product_price,
    p.quantity as product_quantity,
    pm.discount

FROM {{ ref('stg_order') }} as b
LEFT JOIN {{ ref('stg_order_items') }} as i USING (order_id)
LEFT JOIN {{ ref('stg_products') }} as p USING (product_id)
LEFT JOIN {{ ref('stg_promos')}} as pm USING (promo_id)
