{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id,
    product_name,
    count(distinct order_id) as n_distinct_orders,
    count(distinct user_id) as n_distinct_users

FROM {{ ref('fct_orders') }}
GROUP BY product_id, product_name 