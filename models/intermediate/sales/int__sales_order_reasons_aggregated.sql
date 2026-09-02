-- grain: one row per sales_order_id
with sales_order_reason as (

    select *
    from {{ ref("int__sales_order_reasons") }}

),

aggregated as (

    select
        sales_order_id,

        sort_array(collect_set(sales_reason_id)) as sales_reason_ids,
        sort_array(collect_set(sales_reason_name)) as sales_reason_names,
        sort_array(collect_set(sales_reason_type)) as sales_reason_types,

        count(distinct sales_reason_id) as sales_reason_count

    from sales_order_reason
    group by sales_order_id

)

select *
from aggregated
