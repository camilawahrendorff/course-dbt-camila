{{
  config(
    materialized='table'
  )
}}

SELECT 
    user_id,
    min(created_at) as first_session,
    max(created_at) as last_session,
    count(distinct session_id) as distinct_sessions,
    count(distinct page_url) distinct_pages

FROM {{ ref('stg_events') }}
GROUP BY user_id