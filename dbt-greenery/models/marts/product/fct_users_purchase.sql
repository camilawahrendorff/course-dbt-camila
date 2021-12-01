{{
  config(
    materialized='table'
  )
}}

SELECT 
    user_id,
    first_name,
    last_name,
    min(created_at) as first_order,
    max(created_at) as last_order,
    min(case when status = 'delivered' then delivered_at end) as first_deliver,
    max(case when status = 'delivered' then delivered_at end) as last_deliver,
    count(distinct order_id) as number_of_orders,
    avg(delivered_at - created_at) as average_delivery_time,
    sum(order_cost) as total_spent

FROM {{ ref('fct_users_orders') }}
GROUP BY user_id, first_name, last_name