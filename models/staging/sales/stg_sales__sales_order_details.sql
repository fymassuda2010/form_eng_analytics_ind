with source as (

    select *
    from {{ source('adventure_works', 'sales_salesorderdetail') }}

),

renamed as (

    select
        -- primary key
        salesorderdetailid as sales_order_detail_id_pk,

        -- foreign keys
        salesorderid as sales_order_id,
        productid as product_id,
        specialofferid as special_offer_id,

        -- descriptive attributes
        carriertrackingnumber as carrier_tracking_number,

        -- metrics
        orderqty as order_qty,
        unitprice as unit_price,
        unitpricediscount as unit_price_discount,

        -- metadata
        -- rowguid as row_guid,
        modifieddate as modified_date
    from source

)

select *
from renamed
