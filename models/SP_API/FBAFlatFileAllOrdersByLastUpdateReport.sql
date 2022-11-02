{{config(
    materialized='incremental',
    incremental_strategy='merge',
    cluster_by = ['asin', 'sku', 'amazon_order_id'],
    unique_key = ['DATE(purchase_date)', 'asin', 'sku', 'amazon_order_id'])}}


{% if is_incremental() %}
{%- set max_loaded_query -%}
SELECT MAX(_daton_batch_runtime) - 2592000000 FROM {{ this }}
{% endset %}

{%- set max_loaded_results = run_query(max_loaded_query) -%}

{%- if execute -%}
{% set max_loaded = max_loaded_results.rows[0].values()[0] %}
{% else %}
{% set max_loaded = 0 %}
{%- endif -%}
{% endif %}

{% set table_name_query %}
select concat('`', table_catalog,'.',table_schema, '.',table_name,'`') as tables 
from {{ var('project') }}.{{ var('dataset') }}.INFORMATION_SCHEMA.TABLES 
where lower(table_name) like '%flatfileordersbylastupdate%' 
{% endset %}  


{% set results = run_query(table_name_query) %}
{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{% for i in results_list %}
    {% set id =i.split('.')[2].split('_')[1] %}
    SELECT * except(row_num)
    From (
        select
        '{{id}}' as brand,
        CAST(ReportstartDate as timestamp) ReportstartDate,
        CAST(ReportendDate as timestamp) ReportendDate,
        CAST(ReportRequestTime as timestamp) ReportRequestTime,
        sellingPartnerId
        marketplaceName,
        marketplaceId,
        amazon_order_id,
        merchant_order_id,
        cast(DATETIME_ADD(purchase_date, INTERVAL -7 HOUR ) as DATE) purchase_date,
        CAST(last_updated_date as timestamp) last_updated_date,
        order_status, 
        fulfillment_channel, 
        sales_channel,
        order_channel,
        url,
        ship_service_level,
        product_name, 
        sku, 
        asin, 
        item_status, 
        quantity, 
        currency,
        item_price, 
        item_tax, 
        shipping_price, 
        shipping_tax, 
        gift_wrap_price,
        gift_wrap_tax, 
        item_promotion_discount, 
        ship_promotion_discount,
        ship_city, 
        ship_state, 
        ship_postal_code, 
        ship_country,  
        promotion_ids,
        is_business_order,
        purchase_order_number,
        price_designation,
        CURRENT_TIMESTAMP as updated_date,
        _daton_user_id, 
        _daton_batch_runtime, 
        _daton_batch_id, 
        ROW_NUMBER() OVER (PARTITION BY DATE(purchase_date), asin, sku, amazon_order_id order by _daton_batch_runtime desc, last_updated_date desc) row_num
        from {{i}} 
            
            {% if is_incremental() %}
            {# /* -- this filter will only be applied on an incremental run */ #}
            WHERE _daton_batch_runtime  >= {{max_loaded}}
            --WHERE 1=1
            {% endif %}
    
        ) where row_num = 1 
    {% if not loop.last %} union all {% endif %}
{% endfor %}

