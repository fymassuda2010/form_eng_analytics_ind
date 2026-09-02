-- grain: one row per sales order and sales reason
with
    sales_order_reason as (select * from {{ ref("int__sales_order_reasons") }}),

    final as (

        select
            -- grain identifiers
            sales_order_id,
            sales_reason_id,

            -- sales reason attributes
            sales_reason_name,
            sales_reason_type

        from sales_order_reason

    )

select *
from final
