-- The macro will drop the target.schema AND the schemas derived from target.schema
{% macro drop_schema() %}
{% set sql %}
    DECLARE @SqlStatement NVARCHAR(MAX);
    SELECT @SqlStatement = 
        COALESCE(@SqlStatement, N'') + N'DROP TABLE ' + TABLE_SCHEMA + '.' + QUOTENAME(TABLE_NAME) + N';' + CHAR(13)
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA LIKE '%{{ target.schema }}%' and TABLE_TYPE = 'BASE TABLE';
    EXEC (@SqlStatement);
{% endset %}

{% do run_query(sql) %}

{% set sql %}
    DECLARE @SqlStatement NVARCHAR(MAX);
    SELECT @SqlStatement = 
        COALESCE(@SqlStatement, N'') + N'DROP VIEW ' + TABLE_SCHEMA + '.' + QUOTENAME(TABLE_NAME) + N';' + CHAR(13)
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA LIKE '%{{ target.schema }}%' and TABLE_TYPE = 'VIEW';
    EXEC (@SqlStatement);
{% endset %}

{% do run_query(sql) %}

{% set sql %}
    DECLARE @SqlStatement NVARCHAR(MAX);
    SELECT @SqlStatement = 
        COALESCE(@SqlStatement, N'') + N'DROP SCHEMA ' + QUOTENAME(name) + N';' + CHAR(13)
    FROM sys.schemas 
    WHERE name LIKE '%{{ target.schema }}%';
    EXEC (@SqlStatement);
{% endset %}

{% do run_query(sql) %}
{% endmacro %}