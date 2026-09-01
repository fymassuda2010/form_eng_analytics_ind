-- grain: one row per business_entity_id
with
    person_credit_card as (select * from {{ ref("stg_person__credit_card") }}),

    credit_card as (select * from {{ ref("stg_sales__credit_card") }}),

    joined as (

        select
            -- person identifier
            pc.business_entity_id,

            -- credit card identifier
            pc.credit_card_id,

            -- credit card attributes
            cc.card_type,
            cc.card_number,
            cc.exp_month,
            cc.exp_year

        from person_credit_card pc

        left join credit_card cc on pc.credit_card_id = cc.credit_card_id

    )

select *
from joined
