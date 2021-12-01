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
    SPLIT_PART(page_url,'product/',2) as product_id,
    created_at
    
FROM {{ source('greenery_db', 'events') }}