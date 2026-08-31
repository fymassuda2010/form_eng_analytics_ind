with
    base as (

        select
            odet.sales_order_detail_id_pk,
            odet.sales_order_id,
            odet.order_month,
            odet.order_qty,
            odet.net_amount,
            da.address_id,
            da.city,
            da.state_province_code,
            da.state_province_name,
            da.country_region_code

        from {{ ref("gold_fact_sales_order_detail") }} odet
        left join
            {{ ref("gold_dim_delivery_address") }} da
            on odet.ship_to_address_id = da.address_id

    ),

    aggregated as (

        select
            order_month,
            country_region_code,
            state_province_name,
            city,
            sum(order_qty) as total_products_qtt,
            count(distinct sales_order_id) as order_qtt,
            round(sum(net_amount)) as net_amount

        from base
        where order_month >= (select add_months(max(order_month), -5) from base)
        group by 1, 2, 3, 4

    ),

    final as (

        select
            order_month,
            country_region_code,
            state_province_name,
            city,
            'Total products quantity' as metric_name,
            cast(total_products_qtt as int) as metric_value
        from aggregated

        union all

        select
            order_month,
            country_region_code,
            state_province_name,
            city,
            'Order quantity' as metric_name,
            cast(order_qtt as int) as metric_value
        from aggregated

        union all

        select
            order_month,
            country_region_code,
            state_province_name,
            city,
            'Net amount' as metric_name,
            cast(net_amount as int) as metric_value
        from aggregated

    )

select *
from final
