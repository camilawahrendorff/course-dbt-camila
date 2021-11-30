{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id,
    user_id,
    first_name,
    last_name,
    address,
    state,
    country
    
FROM {{ ref('stg_order') }}
LEFT JOIN {{ ref('dim_users') }} USING (user_id)