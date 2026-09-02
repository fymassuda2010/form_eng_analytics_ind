with source as (

    select *
    from {{ source('adventure_works', 'sales_salesterritory') }}

),

renamed as (

    select
        -- primary key
        territoryid as territory_id,

        -- foreign keys
        countryregioncode as country_region_code,

        -- descriptive attributes
        name as territory_name,
        `group` as territory_group,

        -- metrics
        salesytd as sales_ytd_amount,
        saleslastyear as sales_last_year_amount,
        costytd as cost_ytd_amount,
        costlastyear as cost_last_year_amount,

        -- metadata
        modifieddate as modified_date

    from source

)

select *
from renamed
