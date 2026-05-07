{{
    config(
        materialized='ephemeral'
    )
}}
WITH src_airport_comments AS (
    SELECT * FROM {{ source('airstats', 'comments') }}
)
SELECT
    id AS comment_id,
    airport_ident,
    date AS comment_timestamp,
    member_nickname,
    subject AS comment_subject,
    body AS comment_body
FROM src_airport_comments