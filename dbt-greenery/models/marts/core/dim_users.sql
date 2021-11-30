{{
  config(
    materialized='table'
  )
}}

SELECT 
    u.user_id,
    u.created_at,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    a.address,
    a.zipcode,
    a.state,
    a.country,
    CASE WHEN u.updated_at > a.updated_at THEN u.updated_at ELSE a.updated_at END as updated_at,
    u.valid_from,
    u.valid_to

FROM {{ ref('stg_users') }} as u
LEFT JOIN {{ ref('stg_addresses')}} as a USING (address_id)