with
    address as (select * from {{ ref("stg_person__addresses") }}),

    state_province as (select * from {{ ref("stg_person__state_provinces") }}),

    country_region as (select * from {{ ref("int_client__country_regions") }}),

    joined as (

        select
            -- primary key
            address.address_id,

            -- foreign keys
            address.state_province_id,
            state_province.country_region_code,
            state_province.territory_id,

            -- descriptive attributes
            address.address_line_1,
            address.address_line_2,
            address.city,
            address.postal_code,
            state_province.state_province_code,
            country_region.country_region_name,
            state_province.state_province_name

        from address

        left join
            state_province
            on address.state_province_id = state_province.state_province_id

        left join
            country_region
            on state_province.country_region_code = country_region.country_region_code

    )

select *
from joined
