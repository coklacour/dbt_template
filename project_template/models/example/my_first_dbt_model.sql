{{ config(materialized='table') }}

WITH source_data AS (

    SELECT 1 AS id
    UNION ALL
    SELECT null AS id
    UNION ALL
    SELECT null AS id
    UNION ALL
    SELECT 2 AS id

)

SELECT 
    id
    , id + 3 AS id2
FROM source_data
