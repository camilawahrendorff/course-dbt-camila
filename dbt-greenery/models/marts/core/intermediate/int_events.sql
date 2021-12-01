{{
  config(
    materialized='view'
  )
}}

SELECT 
    event_id,
    event_type,
    session_id,
    user_id,
    page_url,
    created_at,
    product_id,
    name as product_name

FROM {{ ref('stg_events') }}
LEFT JOIN {{ ref('stg_products') }} USING (product_id)