{{
  config(
    materialized='table'
  )
}}

WITH base as (
SELECT 
    session_id,
    user_id,
    count(distinct page_url) as number_url,
    count(distinct product_id) as number_products,
    min(created_at) as first_session,
    max(created_at) as last_session,
    {{ event_types('delete_from_cart') }},
    {{ event_types('checkout') }},
    {{ event_types('page_view') }},
    {{ event_types('add_to_cart') }},
    {{ event_types('package_shipped') }},
    {{ event_types('account_created') }}

FROM {{ ref('int_events') }}
GROUP BY 1,2
)

SELECT * 
    , CASE WHEN checkout > 0 THEN true ELSE false END as is_converted
FROM base