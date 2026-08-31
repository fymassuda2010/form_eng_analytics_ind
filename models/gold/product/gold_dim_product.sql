with
    product as (select * from {{ ref("stg_product_product") }}),

    final as (select product_id, product_name, product_number from product)

select *
from final
