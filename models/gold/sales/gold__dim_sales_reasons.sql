with
    sales_reason as (select * from {{ ref("stg_sales__sales_reasons") }}),

    final as (

        select
            -- primary key
            sales_reason_id,

            -- descriptive attributes
            sales_reason_name,
            sales_reason_type
        from sales_reason

    )

select *
from final
