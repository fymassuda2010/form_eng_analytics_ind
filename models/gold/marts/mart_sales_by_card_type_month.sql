with
    base as (

        select
            odet.sales_order_detail_id_pk,
            odet.sales_order_id,
            odet.order_month,
            odet.order_qty,
            odet.net_amount,
            cc.card_type

        from {{ ref("gold_fact_sales_order_detail") }} odet
        left join {{ ref("gold_dim_credit_card") }} cc
            on odet.credit_card_id = cc.credit_card_id

    ),

    aggregated as (

        select
            order_month,
            card_type,
            sum(order_qty) as total_products_qtt,
            count(distinct sales_order_id) as order_qtt,
            round(sum(net_amount), 2) as net_amount

        from base
        where
            card_type is not null
            and order_month >= (
                select add_months(max(order_month), -5)
                from base
            )
        group by
            order_month,
            card_type

    ),

    final as (

        select
            order_month,
            card_type,
            'Total products quantity' as metric_name,
            cast(total_products_qtt as double) as metric_value
        from aggregated

        union all

        select
            order_month,
            card_type,
            'Order quantity' as metric_name,
            cast(order_qtt as double) as metric_value
        from aggregated

        union all

        select
            order_month,
            card_type,
            'Net amount' as metric_name,
            cast(net_amount as double) as metric_value
        from aggregated

    )

select *
from final