with source as (

    select *
    from {{ source('adventure_works', 'sales_salesreason') }}

),

renamed as (

    select
        -- primary key
        salesreasonid as sales_reason_id,

        -- descriptive attributes
        name as sales_reason_name,
        reasontype as sales_reason_type,

        -- metadata
        modifieddate as modified_date
    from source

)

select *
from renamed
