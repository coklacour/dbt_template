{{ anonymizator(
    database=var('databases')['test'],
    schema='test_custom_schema_name',
    table_name='my_first_dbt_model',
    fields_to_anonymized=var('anonymize'),
    fields_to_nullify=var('nullify')
) }}

