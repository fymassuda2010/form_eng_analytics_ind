with person as (

    select *
    from {{ ref('stg_person_person') }}

),

business_entity_address as (

    select *
    from {{ ref('stg_person_business_entity_address') }}

),

address as (

    select *
    from {{ ref('stg_person_address') }}

),

state_province as (

    select *
    from {{ ref('stg_person_state_province') }}

),

country_region as (

    select *
    from {{ ref('stg_person_country_region') }}

),

territory as (

    select *
    from {{ ref('stg_sales_territory') }}

),

joined as (

    select
        -- Person
        p.business_entity_id,
        p.person_type,
        p.first_name,
        p.middle_name,
        p.last_name,

        concat_ws(' ', p.first_name, p.middle_name, p.last_name) as full_name,

        p.email_promotion,
        p.additional_contact_info,

        -- Business Entity Address
        bea.address_id,
        bea.address_type_id,

        -- Address
        a.address_line_1,
        a.address_line_2,
        a.city,
        a.state_province_id,
        a.postal_code,

        -- State Province
        sp.state_province_code,
        sp.country_region_code,
        sp.is_only_state_province_flag,
        sp.state_province_name,
        sp.territory_id,

        -- Country Region
        cr.country_region_name,

        -- Territory
        tr.territory_name

    from person p

    left join business_entity_address bea
        on p.business_entity_id = bea.business_entity_id

    left join address a
        on bea.address_id = a.address_id

    left join state_province sp
        on a.state_province_id = sp.state_province_id

    left join country_region cr
        on sp.country_region_code = cr.country_region_code

    left join territory tr
        on sp.territory_id = tr.territory_id

)

select
    -- Person identifiers
    business_entity_id,
    person_type,

    -- Person name
    first_name,
    middle_name,
    last_name,
    full_name,

    -- Person attributes
    email_promotion,
    additional_contact_info,

    -- Address
    address_id,
    address_type_id,
    address_line_1,
    address_line_2,
    city,
    postal_code,

    -- State / Province
    state_province_id,
    state_province_name,
    state_province_code,
    is_only_state_province_flag,

    -- Country / Region
    country_region_code as  person_country_region_code,
    country_region_name as person_country_region_name,

    -- Territory
    territory_id as person_territory_id,
    territory_name as person_territory_name

from joined