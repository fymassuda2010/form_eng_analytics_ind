with
    address as (

        select *
        from {{ ref("int_client__addresses") }}

    ),

    final as (

        select
            -- primary key
            address_id,

            -- foreign keys
            state_province_id,
            country_region_code,
            territory_id,

            -- descriptive attributes
            address_line_1,
            address_line_2,
            city,
            state_province_code,
            state_province_name,
            country_region_name,
            postal_code

        from address

    )

select *
from final
