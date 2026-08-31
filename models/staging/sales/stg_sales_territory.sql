with source as (

    select *
    from {{ source('adventure_works', 'sales_salesterritory') }}

),

renamed as (

    select
        territoryid as territory_id,
        name as territory_name,
        countryregioncode as country_region_code,
        `group` as territory_group,
        salesytd as sales_ytd_amount,
        saleslastyear as sales_last_year_amount,
        costytd as cost_ytd_amount,
        costlastyear as cost_last_year_amount,
        modifieddate as modified_date

    from source

)

select *
from renamed