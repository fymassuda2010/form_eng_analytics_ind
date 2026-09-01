with
    sales_order_header_sales_reason as (

        select * from {{ ref("stg_sales__sales_order_header_sales_reason") }}

    ),

    sales_reason as (select * from {{ ref("stg_sales__sales_reason") }}),

    joined as (

        select
            -- grain: one row per sales order and sales reason
            soh_sr.sales_order_id,
            soh_sr.sales_reason_id,

            -- sales reason attributes
            sr.sales_reason_name,
            sr.sales_reason_type

        from sales_order_header_sales_reason soh_sr

        left join sales_reason sr on soh_sr.sales_reason_id = sr.sales_reason_id

    )

select
    sales_order_id,
    sales_reason_id,
    sales_reason_name,
    sales_reason_type
from joined
