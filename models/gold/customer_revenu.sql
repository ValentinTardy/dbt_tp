{{ config(
    materialized='table',
    schema='gold'
) }}


SELECT c.customerid, c.fullname, SUM(f.number_of_orders) as number_of_orders, SUM(f.total_revenue) as total_revenue
FROM {{ ref('stg_customers') }} AS c
INNER JOIN {{ ref('fact_orders') }} AS f
    ON c.customerid = f.customerid

GROUP BY c.customerid, c.fullname
