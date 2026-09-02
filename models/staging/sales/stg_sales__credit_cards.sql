with source as (

    select *
    from {{ source('adventure_works', 'sales_creditcard') }}

),

renamed as (

    select
        -- primary key
        cast(creditcardid as int) as credit_card_id,

        -- expiration date attributes
        expmonth as exp_month,
        expyear as exp_year,

        -- descriptive attributes
        cardtype as card_type,
        cardnumber as card_number,

        -- metadata
        modifieddate as modified_date

    from source

)

select *
from renamed
