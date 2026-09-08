with validation as (

    select
        round(sum(gross_amount), 2) as gross_sales_2011

    from {{ ref('gold__fact_sales_order_details') }}

    where year(order_date) = 2011

)

select *
from validation

where gross_sales_2011 <> 12646112.16
