-- https://pub.towardsai.net/dbt-override-default-schema-with-custom-schema-name-tip-1-2e6ec59141b7
-- https://docs.getdbt.com/docs/build/custom-schemas
-- By default, custom_schema name will be combined with target.schema name
-- Override this schema to based on requirements

{% macro generate_schema_name(custom_schema_name, node) -%}
    
    {%- set default_schema = target.schema -%}
    
    {%- if var("custom_schema_override") is true -%}
        {%- if custom_schema_name is none -%}
            {{ default_schema }}
            {{ log("Setting Default Schema: {0}".format(target.schema)) }}
        {%- else -%}
            {{ custom_schema_name | trim }}
            {{ log("Setting Custom Schema: {0}".format(custom_schema_name | trim)) }}
        {%- endif -%}

    {%- else -%}
        {%- if custom_schema_name is none -%}
            {{ default_schema }}
        {%- else -%}
            {{ default_schema }}_{{ custom_schema_name | trim }}
        {%- endif -%}
    
    {%- endif -%}

{%- endmacro %}
