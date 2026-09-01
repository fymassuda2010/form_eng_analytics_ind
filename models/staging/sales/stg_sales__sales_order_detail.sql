with source as (

    select *
    from {{ source('adventure_works', 'sales_salesorderdetail') }}

),

renamed as (

    select
        salesorderdetailid as sales_order_detail_id_pk,
        salesorderid as sales_order_id,
        carriertrackingnumber as carrier_tracking_number,
        orderqty as order_qty,
        productid as product_id,
        specialofferid as special_offer_id,
        unitprice as unit_price,
        unitpricediscount as unit_price_discount,
        --rowguid as row_guid,
        modifieddate as modified_date
    from source

)

select *
from renamed