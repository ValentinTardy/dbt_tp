
{% snapshot customers_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='customerid',
        strategy='timestamp',
        updated_at='updated_at'
    )
}}

SELECT *
FROM {{ source('bronze', 'customers') }}

{% endsnapshot %}
