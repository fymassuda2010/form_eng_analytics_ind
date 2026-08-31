with sales_order_header as (

    select *
    from {{ ref('stg_sales_order_header') }}

),

final as (

    select
        -- grain: one row per sales order
        sales_order_id,

        -- order info
        revision_number,
        order_date,
        due_date,
        ship_date,
        date_trunc('month', order_date)::date as order_month,
        sales_order_status,
        online_order_flag,
        purchase_order_number,
        account_number,

        -- foreign keys
        customer_id,
        sales_person_id,
        territory_id,
        bill_to_address_id,
        ship_to_address_id,
        ship_method_id,
        credit_card_id,
        currency_rate_id,

        -- transaction attributes
        credit_card_approval_code,

        -- order-level metrics
        subtotal_amount,
        tax_amount,
        freight_amount,
        total_due_amount

    from sales_order_header

)

select *
from final