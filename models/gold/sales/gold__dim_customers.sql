-- grain: one row per customer_id
with customer as (

    select
        customer_id,
        person_id,
        store_id,
        territory_id,
        modified_date
    from {{ ref("stg_sales__customers") }}

),

person as (

    select
        business_entity_id,
        person_type,
        first_name,
        middle_name,
        last_name,
        full_name,
        email_promotion
    from {{ ref("int_client__persons") }}

),

final as (

    select
        -- primary key
        customer.customer_id,

        -- foreign keys
        customer.person_id,
        customer.store_id,
        customer.territory_id,

        -- descriptive attributes
        person.person_type,
        person.first_name,
        person.middle_name,
        person.last_name,
        person.full_name,
        person.email_promotion,

        -- metadata
        customer.modified_date

    from customer

    left join person
        on customer.person_id = person.business_entity_id

)

select *
from final
