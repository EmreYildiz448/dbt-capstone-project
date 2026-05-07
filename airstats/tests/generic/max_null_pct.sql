{% test max_null_pct(model, column_name) %}

{{ config(fail_calc = "failure_bps") }}

WITH stats AS (
    SELECT
        COUNT(*) AS total_rows,
        COUNT_IF({{ column_name }} IS NULL) AS null_rows
    FROM {{ model }}
)

SELECT
    ROUND(10000 * null_rows::FLOAT / NULLIF(total_rows, 0))::INT AS failure_bps
FROM stats

{% endtest %}