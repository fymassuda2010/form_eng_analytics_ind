-- grain: one row per customer_id
with customer as (

    select
        customer_id,
        person_id,
        store_id,
        territory_id,
        modified_date
    from {{ ref("stg_sales__customers") }}

)

select
    -- primary key
    customer_id,

    -- foreign keys
    person_id,
    store_id,
    territory_id,

    -- metadata
    modified_date
from customer
