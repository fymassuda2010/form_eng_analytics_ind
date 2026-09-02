with source as (

    select *
    from {{ source('adventure_works', 'sales_salesorderheadersalesreason') }}

),

renamed as (

    select
        -- composite key / foreign keys
        salesorderid as sales_order_id,
        salesreasonid as sales_reason_id,

        -- metadata
        modifieddate as modified_date
    from source

)

select *
from renamed
