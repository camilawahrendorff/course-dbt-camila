{{
  config(
    materialized='table'
  )
}}

with base as (
SELECT 
    page_url,
    product_id,
    product_name,
    session_id,
    count(distinct user_id) as users,
    min(created_at) as first_session,
    max(created_at) as last_session,
    {{ event_types('delete_from_cart') }},
    {{ event_types('checkout') }},
    {{ event_types('page_view') }},
    {{ event_types('add_to_cart') }},
    {{ event_types('package_shipped') }},
    {{ event_types('account_created') }}

FROM {{ ref('int_events') }}
GROUP BY 1,2,3,4
)

SELECT * 
    , CASE WHEN checkout > 0 THEN true ELSE false END as is_converted
FROM base