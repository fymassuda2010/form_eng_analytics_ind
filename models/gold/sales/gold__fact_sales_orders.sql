-- grain: one row per sales_order_id
with sales_order_header as (

    select *
    from {{ ref('stg_sales__order_headers') }}

),

final as (

    select
        -- primary key / grain
        sales_order_id,

        -- foreign keys
        customer_id,
        sales_person_id,
        territory_id,
        bill_to_address_id,
        ship_to_address_id,
        ship_method_id,
        credit_card_id,
        currency_rate_id,

        -- dates
        order_date,
        date_trunc('month', order_date)::date as order_month,
        due_date,
        ship_date,

        -- descriptive attributes
        revision_number,
        sales_order_status,
        online_order_flag,
        purchase_order_number,
        account_number,
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
