with customer as (

    select *
    from {{ ref('int_customer') }}

)

select
    -- customer identifiers
    customer_id,
    person_id,
    store_id,
    business_entity_id,

    -- address identifiers
    address_id,
    address_type_id,
    customer_territory_id,
    state_province_id,

    -- person/customer attributes
    person_type,
    full_name,
    email_promotion,
    additional_contact_info,

    -- address
    address_line_1,
    address_line_2,
    city,
    postal_code,

    -- customer territory
    customer_territory_name,
    customer_territory_country_region_code,
    customer_territory_group,

    -- state / province
    state_province_name,
    state_province_code,
    is_only_state_province_flag

from customer