with source as (

    select *
    from {{ source('adventure_works', 'person_countryregion') }}

),

renamed as (

    select
        -- primary key
        countryregioncode as country_region_code,

        -- descriptive attributes
        name as country_region_name,

        -- metadata
        modifieddate as modified_date
    from source

)

select *
from renamed
