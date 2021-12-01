{{
  config(
    materialized='table'
  )
}}

SELECT 

    page_url,
    product_id,
    product_name,
    min(created_at) as created_at

FROM {{ ref('int_events') }}
GROUP BY 1,2,3