with customer as (

    select *
    from {{ ref('stg_sales_customer') }}

),

person as (

    select *
    from {{ ref('int_person') }}

),

territory as (

    select *
    from {{ ref('stg_sales_territory') }}

),

joined as (

    select
        -- customer identifiers
        c.customer_id,
        c.person_id,
        c.storeid as store_id,
        c.territory_id as customer_territory_id,

        -- person identifiers
        p.business_entity_id,
        p.address_id,
        p.address_type_id,
        p.state_province_id,

        -- person/customer attributes
        p.person_type,
        p.full_name,
        p.email_promotion,
        p.additional_contact_info,

        -- customer address
        p.address_line_1,
        p.address_line_2,
        p.city,
        p.postal_code,

        -- customer territory
        t.territory_name as customer_territory_name,
        t.country_region_code as customer_territory_country_region_code,
        t.territory_group as customer_territory_group,

        -- state / province
        p.state_province_name,
        p.state_province_code,
        p.is_only_state_province_flag

    from customer c

    left join person p
        on c.person_id = p.business_entity_id

    left join territory t
        on c.territory_id = t.territory_id

)

select
    -- customer identifiers
    customer_id,
    person_id,
    store_id,
    customer_territory_id,

    -- person identifiers
    business_entity_id,
    address_id,
    address_type_id,
    state_province_id,

    -- person/customer attributes
    person_type,
    full_name,
    email_promotion,
    additional_contact_info,

    -- customer address
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

from joined