with
    sales_reason as (select * from {{ ref("stg_sales_sales_reason") }}),

    final as (

        select sales_reason_id, sales_reason_name, sales_reason_type from sales_reason

    )

select *
from final
