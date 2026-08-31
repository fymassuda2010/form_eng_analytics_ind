with source as (

    select *
    from {{ source('adventure_works', 'sales_salesorderheader') }}

),

renamed as (

    select
        -- id
        salesorderid as sales_order_id,

        -- order info
        revisionnumber as revision_number,
        cast(orderdate as date) as order_date,
        cast(duedate as date) as due_date,
        cast(shipdate as date) as ship_date,
        status as sales_order_status,
        onlineorderflag as online_order_flag,
        purchaseordernumber as purchase_order_number,
        accountnumber as account_number,

        -- foreign keys
        customerid as customer_id,
        salespersonid as sales_person_id,
        territoryid as territory_id,
        billtoaddressid as bill_to_address_id,
        shiptoaddressid as ship_to_address_id,
        shipmethodid as ship_method_id,
        creditcardid as credit_card_id,
        currencyrateid as currency_rate_id,

        -- credit card info
        creditcardapprovalcode as credit_card_approval_code,

        -- metrics
        subtotal as subtotal_amount,
        taxamt as tax_amount,
        freight as freight_amount,
        totaldue as total_due_amount

        -- metadata
        -- comment as comment,
        -- modifieddate as modified_date

    from source

)

select *
from renamed