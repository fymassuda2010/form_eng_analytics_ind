with person as (

    select
        -- primary key
        business_entity_id,

        -- descriptive attributes
        person_type,
        first_name,
        middle_name,
        last_name,
        email_promotion,
        modified_date
    from {{ ref('stg_person__persons') }}

),

final as (

    select
        business_entity_id,
        person_type,
        first_name,
        middle_name,
        last_name,
        trim(concat_ws(' ', first_name, middle_name, last_name)) as full_name,
        email_promotion,

        -- metadata
        modified_date
    from person

)

select *
from final
