{% macro drop_empty_test_failure_tables() %}

    {% set failure_schema = target.schema ~ '__TEST_FAILURES_SILVER' %}

    {% set list_tables_sql %}
        SELECT table_name
        FROM {{ target.database }}.information_schema.tables
        WHERE table_schema = UPPER('{{ failure_schema }}')
          AND table_type = 'BASE TABLE'
    {% endset %}

    {% if execute %}

        {% set tables = run_query(list_tables_sql) %}

        {% if tables is not none %}

            {% for row in tables.rows %}

                {% set table_name = row[0] %}
                {% set full_table_name = target.database ~ '.' ~ failure_schema ~ '.' ~ table_name %}

                {% set check_sql %}
                    SELECT 1
                    FROM {{ full_table_name }}
                    LIMIT 1
                {% endset %}

                {% set check_result = run_query(check_sql) %}

                {% if check_result.rows | length == 0 %}

                    {% set drop_sql %}
                        DROP TABLE IF EXISTS {{ full_table_name }}
                    {% endset %}

                    {% do run_query(drop_sql) %}

                {% endif %}

            {% endfor %}

        {% endif %}

    {% endif %}

{% endmacro %}