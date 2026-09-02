with country_region as (

    select *
    from {{ ref("stg_person__country_regions") }}

),

final as (

    select
        -- primary key
        -- correcting Namibia, which is null in the source
        case
            when country_region_name = 'Namibia' and country_region_code is null
                then 'NA'
            else country_region_code
        end as country_region_code,

        -- descriptive attributes
        country_region_name,

        -- metadata
        modified_date

    from country_region

)

select *
from final
