with source as (

    select *
    from {{ source('adventure_works', 'person_businessentityaddress') }}

),

renamed as (

    select
        addressid as address_id,
        businessentityid as business_entity_id,
        addresstypeid as address_type_id,
        modifieddate as modified_date
    from source

)

select *
from renamed