with source as (

    select *
    from {{ source('adventure_works', 'person_businessentity') }}

),

renamed as (

    select
        businessentityid as business_entity_id,
        rowguid as row_guid,
        modifieddate as modified_date
    from source

)

select *
from renamed