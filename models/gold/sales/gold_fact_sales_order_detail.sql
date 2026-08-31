-- grain: one row per sales_order_detail_id_pk
with sales_order_detail as (

    select *
    from {{ ref('int_sales_order_detail') }}

),

final as (

    select
        -- primary key / grain
        sales_order_detail_id_pk,

        -- degenerate dimension
        sales_order_id,

        -- foreign keys
        customer_id,
        territory_id,
        credit_card_id,
        bill_to_address_id,
        ship_to_address_id,
        ship_method_id,
        currency_rate_id,
        product_id,
        special_offer_id,

        -- order attributes
        revision_number,
        order_date,
        order_month,
        due_date,
        ship_date,
        sales_order_status,
        online_order_flag,
        purchase_order_number,
        account_number,
        credit_card_approval_code,

        -- tracking
        carrier_tracking_number,

        -- metrics
        order_qty,
        unit_price,
        unit_price_discount,
        gross_amount,
        discount_amount,
        net_amount

    from sales_order_detail

)

select *
from final