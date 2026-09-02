with source as (

    select *
    from {{ source('adventure_works', 'sales_customer') }}

),

renamed as (

    select
        -- primary key
        customerid as customer_id,

        -- foreign keys
        cast(personid as int) as person_id,
        cast(storeid as int) as store_id,
        territoryid as territory_id,

        -- metadata
        modifieddate as modified_date

    from source

)

select *
from renamed
