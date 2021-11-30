{% snapshot order_items_snapshot %}

  {{
    config(
      target_schema='snapshots',
      strategy='check',
      unique_key='order_id',
      check_cols=['order_id', 'quantity'],
    )
  }}

  SELECT * 
  FROM {{ source('greenery_db', 'order_items') }}

{% endsnapshot %}