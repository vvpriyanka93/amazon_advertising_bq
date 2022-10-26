{% set table_name_query %}
select  concat('`', table_catalog,'.',table_schema, '.',table_name,'`') as tables 
from {{ var('project') }}.{{ var('dataset') }}.INFORMATION_SCHEMA.TABLES 
where lower(table_name) like '%txnsrevcomparison%' 
{% endset %}  
{% set results = run_query(table_name_query) %}
{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}
{% for i in results_list %}
    {% set id =i.split('.')[2].split('_')[0] %}
    SELECT start_date
    from {{i}} 
    {% if not loop.last %} union all {% endif %}
{% endfor %}