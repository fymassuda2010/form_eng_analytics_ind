-- grain: one row per sales_order_detail_id_pk
with
    sales_order_detail as (select * from {{ ref("stg_sales_sales_order_detail") }}),

    sales_order_header as (select * from {{ ref("stg_sales_order_header") }}),

    joined as (

        select
            -- main identifiers
            sod.sales_order_detail_id_pk,
            sod.sales_order_id,

            -- identifiers
            soh.customer_id,
            soh.territory_id,
            soh.credit_card_id,
            soh.bill_to_address_id,
            soh.ship_to_address_id,
            soh.ship_method_id,
            soh.currency_rate_id,

            -- product
            sod.product_id,
            sod.special_offer_id,

            -- order attributes
            soh.revision_number,
            soh.order_date,
            date_trunc('month', soh.order_date)::date as order_month,
            soh.due_date,
            soh.ship_date,
            soh.sales_order_status,
            soh.online_order_flag,
            soh.purchase_order_number,
            soh.account_number,
            soh.credit_card_approval_code,

            -- tracking
            sod.carrier_tracking_number,

            -- metrics
            sod.order_qty,
            sod.unit_price,
            sod.unit_price_discount,
            sod.order_qty * sod.unit_price as gross_amount,
            sod.order_qty * sod.unit_price * sod.unit_price_discount as discount_amount,
            sod.order_qty
            * sod.unit_price
            * (1 - sod.unit_price_discount) as net_amount

        from sales_order_detail sod

        left join sales_order_header soh on sod.sales_order_id = soh.sales_order_id

    )

select *
from joined
