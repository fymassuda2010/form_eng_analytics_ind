with
    product as (

        select
            product_id,
            product_name,
            product_number,
            make_flag,
            finished_goods_flag,
            color,
            safety_stock_level,
            reorder_point,
            standard_cost,
            list_price,
            product_size,
            size_unit_measure_code,
            weight_unit_measure_code,
            product_weight,
            days_to_manufacture,
            product_line,
            class,
            style,
            product_subcategory_id,
            product_model_id,
            sell_start_date,
            sell_end_date,
            discontinued_date,
            modified_date
        from {{ ref("stg_product_product") }}

    )

select *
from product
