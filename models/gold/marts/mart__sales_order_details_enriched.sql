-- grain: one row per sales_order_detail_id_pk
with order_details as (

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

        -- dates
        order_date,
        order_month,
        due_date,
        ship_date,

        -- descriptive attributes
        revision_number,
        sales_order_status,
        online_order_flag,
        purchase_order_number,
        account_number,
        credit_card_approval_code,

        carrier_tracking_number,

        -- metrics
        order_qty,
        unit_price,
        unit_price_discount,
        gross_amount,
        discount_amount,
        net_amount

    from {{ ref("gold__fact_sales_order_details") }}

),

credit_card as (

    select
        credit_card_id,
        card_type,
        card_number,
        exp_month,
        exp_year

    from {{ ref("gold__dim_credit_cards") }}

),

customer as (

    select
        customer_id,
        person_id,
        store_id

    from {{ ref("gold__dim_customers") }}

),

sales_reason as (

    select
        sales_order_id,
        sales_reason_ids,
        sales_reason_names,
        sales_reason_types,
        sales_reason_count

    from {{ ref("gold__dim_sales_reasons_by_order_id") }}

),

delivery_address as (

    select
        address_id,
        address_line_1,
        address_line_2,
        city,
        state_province_id,
        state_province_code,
        state_province_name,
        country_region_code,
        country_region_name,
        postal_code,
        territory_id

    from {{ ref("gold__dim_delivery_addresses") }}

),

product as (

    select
        product_id,
        product_name,
        product_number
    from {{ ref("gold__dim_products") }}

),

final as (

    select
        -- primary key / grain
        orders.sales_order_detail_id_pk,

        -- degenerate dimension
        orders.sales_order_id,

        -- foreign keys
        orders.customer_id,
        customer.person_id,
        customer.store_id,
        orders.product_id,

        -- dates
        orders.order_date,
        orders.order_month,
        year(orders.order_date) as order_year,

        -- descriptive attributes
        product.product_name,
        product.product_number,
        cards.card_type,
        orders.sales_order_status,
        reasons.sales_reason_ids,
        reasons.sales_reason_names,
        reasons.sales_reason_types,
        reasons.sales_reason_count,
        address.city as delivery_city,
        address.state_province_code as delivery_state_code,
        address.state_province_name as delivery_state_name,
        address.country_region_code as delivery_country_code,
        address.country_region_name as delivery_country_name,

        -- metrics
        orders.order_qty,
        orders.gross_amount,
        orders.discount_amount,
        orders.net_amount

    from order_details orders

    left join product
        on orders.product_id = product.product_id

    left join credit_card cards
        on orders.credit_card_id = cards.credit_card_id

    left join customer
        on orders.customer_id = customer.customer_id

    left join sales_reason reasons
        on orders.sales_order_id = reasons.sales_order_id

    left join delivery_address address
        on orders.ship_to_address_id = address.address_id

)

select *
from final
