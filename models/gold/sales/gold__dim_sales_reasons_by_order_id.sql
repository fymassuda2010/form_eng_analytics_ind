-- grain: one row per sales_order_id
with sales_order_reasons as (

    select *
    from {{ ref("int__sales_order_reasons_aggregated") }}

),

final as (

    select
        -- primary key / grain
        sales_order_id,

        -- sales reasons
        sales_reason_ids,
        sales_reason_names,
        sales_reason_types,
        sales_reason_count

    from sales_order_reasons

)

select *
from final
