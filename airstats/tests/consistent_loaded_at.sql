SELECT * FROM {{ ref('silver_airport_comments') }}
WHERE comment_timestamp > loaded_at