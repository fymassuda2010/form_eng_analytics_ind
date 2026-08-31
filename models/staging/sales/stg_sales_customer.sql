with source as (

    select *
    from {{ source('adventure_works', 'sales_customer') }}

),

renamed as (

    select
        customerid as customer_id,
        cast(personid as int) as person_id,
        cast(storeid as int) as storeid,
        territoryid as territory_id,
        modifieddate as modified_date

    from source

)

select *
from renamed