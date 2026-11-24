
{{ config(materialized='table', schema='gold') }}

WITH orders_by_store AS (
    SELECT
        storeid,
        COUNT(DISTINCT orderid) AS number_of_orders
    FROM {{ ref('orders') }}
    GROUP BY storeid
),

revenue_by_store AS (
    SELECT
        storeid,
        SUM(total_revenue) AS actual_revenue
    FROM {{ ref('fact_orders') }}
    GROUP BY storeid
),

targets_by_store AS (
    SELECT
        StoreID AS storeid,
        SUM(SalesTarget) AS sales_target
    FROM {{ ref('salestarget') }}
    GROUP BY StoreID
),

all_stores AS (
    SELECT storeid FROM orders_by_store
    UNION
    SELECT storeid FROM revenue_by_store
    UNION
    SELECT storeid FROM targets_by_store
)

SELECT
    s.storeid,
    COALESCE(o.number_of_orders, 0) AS number_of_orders,
    COALESCE(r.actual_revenue, 0) AS actual_revenue,
    COALESCE(t.sales_target, 0) AS sales_target
FROM all_stores AS s
LEFT JOIN orders_by_store AS o
    ON s.storeid = o.storeid
LEFT JOIN revenue_by_store AS r
    ON s.storeid = r.storeid
LEFT JOIN targets_by_store AS t
    ON s.storeid = t.storeid
