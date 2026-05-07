{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='comment_id'
    )
}}
WITH silver_airport_comments AS (
    SELECT * FROM {{ ref('src_airport_comments') }}
)
SELECT
    comment_id,
    airport_ident,
    comment_timestamp,
    NVL(member_nickname, '__UNKNOWN__') AS member_nickname,
    comment_subject,
    comment_body,
    CURRENT_TIMESTAMP() AS loaded_at
FROM silver_airport_comments
WHERE comment_body IS NOT NULL
{% if is_incremental() %}
    AND comment_id > (SELECT MAX(comment_id) FROM {{ this }})
{% endif %}