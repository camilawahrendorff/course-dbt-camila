{{
  config(
    materialized='table'
  )
}}

SELECT 
    page_url,
    product_id,
    product_name,
    count(distinct session_id) as visits,
    count(distinct user_id) as users,
    min(created_at) as first_session,
    max(created_at) as last_session,
    SUM(CASE WHEN event_type = 'delete_from_cart' THEN 1 ELSE 0 END)    AS  delete_from_cart,
    SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END)            AS  checkout,
    SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END)           AS  page_view,
    SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END)         AS  add_to_cart,
    SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END)     AS  package_shipped,
    SUM(CASE WHEN event_type = 'account_created' THEN 1 ELSE 0 END)     AS  account_created

FROM {{ ref('int_events') }}
GROUP BY 1,2,3