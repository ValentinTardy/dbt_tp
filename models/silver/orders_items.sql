{{ config(materialized='view') }}

select
    *,
    quantity * unitprice as TotalPrice
from {{ source('bronze', 'orderitems') }}