-- grain: one row per product_id
with
    product as (select * from {{ ref("stg_product__products") }}),

    final as (

        select
            -- primary key
            product_id,

            -- descriptive attributes
            product_name,
            product_number
        from product

    )

select *
from final
