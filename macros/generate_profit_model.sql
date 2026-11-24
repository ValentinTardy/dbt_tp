{% macro generate_profit_model(source_table, eur_rate) %}

select
    sales_date,
    sum(quantity_sold * unit_sell_price)                                           as total_revenue,
    sum(quantity_sold * unit_purchase_cost)                                        as total_cost,
    sum(quantity_sold * unit_sell_price) - sum(quantity_sold * unit_purchase_cost) as total_profit,
    round(
        (sum(quantity_sold * unit_sell_price) - sum(quantity_sold * unit_purchase_cost)) * {{ eur_rate }},
        2
    )                                                                              as total_profit_eur
from {{ source('training', source_table) }}
group by sales_date

{% endmacro %}