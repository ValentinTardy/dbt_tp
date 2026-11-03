{{ config(materialized='view') }}

select
    *,
    case status
        when '01' then 'En cours'
        when '02' then 'Terminée'
        when '03' then 'Annulée'
    end as StatusDescription
from {{ source('bronze', 'orders') }}