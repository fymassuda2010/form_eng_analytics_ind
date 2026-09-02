-- grain: one row per credit_card_id
with credit_card as (

    select *
    from {{ ref('stg_sales__credit_cards') }}

),

final as (

    select
        -- primary key
        credit_card_id,

        -- expiration date attributes
        exp_month,
        exp_year,

        -- descriptive attributes
        card_type,
        card_number

    from credit_card

)

select *
from final
