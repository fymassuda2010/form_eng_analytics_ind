with
    address as (select * from {{ ref("stg_person__address") }}),

    state_province as (select * from {{ ref("stg_person__state_province") }}),

    joined as (

        select
            address.address_id,
            address.address_line_1,
            address.address_line_2,
            address.city,
            address.state_province_id,
            address.postal_code,

            state_province.state_province_code,
            state_province.country_region_code,
            state_province.state_province_name,
            state_province.territory_id

        from address

        left join
            state_province
            on address.state_province_id = state_province.state_province_id

    )

select *
from joined
