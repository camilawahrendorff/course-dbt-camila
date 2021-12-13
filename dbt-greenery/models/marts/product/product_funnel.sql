{{
  config(
    materialized='table'
  )
}}

-- Sessions with any event of type page_view / add_to_cart / checkout
-- Sessions with any event of type add_to_cart / checkout
-- Sessions with any event of type checkout

WITH base as(
SELECT 
    session_id,
    CASE WHEN sum(page_view) > 0 THEN true END as page_view,
    CASE WHEN sum(add_to_cart) > 0 THEN true END as add_to_cart,
    CASE WHEN sum(checkout) > 0 THEN true END as checkout
FROM {{ ref ('fct_page_engagement')}}
GROUP BY 1
)

, events as (
SELECT 
    count(distinct session_id)::decimal as sessions, 
    count(distinct case when page_view then session_id end)::decimal as page_view, 
    count(distinct case when page_view and add_to_cart then session_id end)::decimal as add_to_cart, 
    count(distinct case when checkout and page_view and add_to_cart then session_id end)::decimal as checkout
FROM base  
)

SELECT *,
    (1 - (page_view / sessions)::decimal(32,2)) * 100 as page_view_dropp_off,
    (1 - (add_to_cart / page_view)::decimal(32,2)) * 100 as add_to_cart_dropp_off,
    (1 - (checkout / add_to_cart)::decimal(32,2)) * 100 as checkout_dropp_off,
    (1 - (checkout / sessions)::decimal(32,2)) * 100 as total_conversion
FROM events
