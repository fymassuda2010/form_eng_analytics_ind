with source as (

    select *
    from {{ source('adventure_works', 'person_address') }}

),

renamed as (

    select
        -- primary key
        addressid as address_id,

        -- foreign keys
        stateprovinceid as state_province_id,

        -- descriptive attributes
        addressline1 as address_line_1,
        addressline2 as address_line_2,
        city,
        postalcode as postal_code,

        -- metadata
        modifieddate as modified_date
    from source

)

select *
from renamed
