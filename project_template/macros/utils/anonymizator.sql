{% macro anonymizator(database, schema, table_name, fields_to_anonymized, fields_to_nullify) %}

{# convert fields of interest to lower case #}
{%- set fields_to_anonymized = fields_to_anonymized | map('lower') | list -%}
{%- set fields_to_nullify = fields_to_nullify | map('lower') | list -%}

{# Retrieve column names and data types #}
{%- call statement('cols', fetch_result=True) -%}
    SELECT column_name, data_type
    FROM {{ database }}.INFORMATION_SCHEMA.columns
    WHERE 
        LOWER(table_name) = '{{ table_name | lower }}' 
        AND LOWER(table_schema) = '{{ schema | lower }}' 
        AND data_type <> 'timestamp'
{%- endcall -%}
{%- set column_names = load_result('cols') -%}

{# Generate SQL query to anonymize / nullify data #}
SELECT 
{% for field_tuple in column_names['data'] -%}
    {%- set field = field_tuple[0]|lower -%}
    {%- if field in fields_to_anonymized %}
        HASHBYTES('SHA2_256', CAST({{ field }} AS NVARCHAR(36)) ) AS {{ field }} 
    {%- elif field in fields_to_nullify %}
        NULL AS {{ field }}
    {%- else -%}
        {{ field | indent(4, true)}}
    {%- endif %}
    {%- if not loop.last -%},{% endif %}
{% endfor -%}
FROM {{ database }}.{{ schema }}.{{ table_name }}

{% endmacro %}