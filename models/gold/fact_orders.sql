{{ config(
    materialized='table',
    schema='gold'
) }}

SELECT
    o.customerid,
    o.employeeid,
    o.storeid,
    o.status,
    COUNT(DISTINCT o.orderid) AS number_of_orders,
    SUM(oi.quantity * oi.unitprice) AS total_revenue

FROM {{ ref('orders') }} AS o
INNER JOIN {{ ref('orders_items') }} AS oi
    ON o.orderid = oi.orderid

GROUP BY
    o.customerid,
    o.employeeid,
    o.storeid,
    o.status