-- grain: one row per credit_card_id
with credit_card as (

    select *
    from {{ ref('stg_credit_card') }}

),

final as (

    select
        -- identifier
        credit_card_id,

        -- credit card attributes
        card_type,
        card_number,
        exp_month,
        exp_year

    from credit_card

)

select *
from final