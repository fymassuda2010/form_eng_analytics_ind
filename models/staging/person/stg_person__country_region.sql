with source as (

    select *
    from {{ source('adventure_works', 'person_countryregion') }}

),

renamed as (

    select
        case
            when name = 'Namibia' and countryregioncode is null then 'NA'
            else countryregioncode
        end as country_region_code,

        name as country_region_name,
        modifieddate as modified_date
    from source

)

select *
from renamed