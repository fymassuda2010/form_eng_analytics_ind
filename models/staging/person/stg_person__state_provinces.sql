with
    source as (select * from {{ source("adventure_works", "person_stateprovince") }}),

    renamed as (

        select
            -- primary key
            stateprovinceid as state_province_id,

            -- foreign keys
            countryregioncode as country_region_code,
            territoryid as territory_id,

            -- descriptive attributes
            stateprovincecode as state_province_code,
            isonlystateprovinceflag as is_only_state_province_flag,
            name as state_province_name,

            -- metadata
            rowguid as row_guid,
            modifieddate as modified_date
        from source

    )

select *
from renamed
