{{ config(materialized='view') }}

select
    customerid,
    upper(firstname)                    as firstname,
    lastname,
    concat(firstname, ' ', lastname)    as fullname,
    email,
    phone,
    address,
    city,
    state,
    zipcode,
    updated_at
from {{ source('bronze', 'customers') }}