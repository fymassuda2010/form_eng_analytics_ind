with
    address as (

        select *
        from {{ ref("int_person_address") }}

    ),

    final as (

        select
            address_id,
            address_line_1,
            address_line_2,
            city,
            state_province_id,
            state_province_code,
            state_province_name,
            country_region_code,
            postal_code,
            territory_id

        from address

    )

select *
from final