--To disable this model, set the sp_flatfilev2settlement variable within your dbt_project.yml file to False.
{{ config(enabled=var('FBAAmazonFulfilledShipmentsReport', True)) }}

{{config(
    materialized='incremental',
    incremental_strategy='merge',
    cluster_by = ['sku','amazon_order_id'],
    unique_key = ['purchase_date', 'sku', 'amazon_order_id'])}}


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
from {{ var('raw_projectid') }}.{{ var('raw_dataset') }}.INFORMATION_SCHEMA.TABLES 
where lower(table_name) like '%fulfilledshipments%' 
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
    SELECT * except(row_num),
    From (
        select
        CAST(ReportstartDate as timestamp) ReportstartDate,
        CAST(ReportendDate as timestamp) ReportendDate,
        CAST(ReportRequestTime as timestamp) ReportRequestTime,
        sellingPartnerId,
        marketplaceName,
        marketplaceId,
        amazon_order_id,
        merchant_order_id,
        shipment_id,
        shipment_item_id,
        amazon_order_item_id,
        merchant_order_item_id,
        CAST(DATETIME_ADD(timestamp(purchase_date), INTERVAL -7 HOUR ) as DATE) purchase_date,
        CAST(timestamp(payments_date) as DATE) payments_date,
        CAST(timestamp(shipment_date) as DATE) shipment_date,
        CAST(timestamp(reporting_date) as DATE) reporting_date,
        buyer_email,
        buyer_name,
        buyer_phone_number,
        sku,
        product_name,
        quantity_shipped,
        currency,
        item_price,
        item_tax,
        shipping_price,
        shipping_tax,
        gift_wrap_price,
        gift_wrap_tax,
        ship_service_level,
        recipient_name,
        ship_address_1,
        ship_address_2,
        ship_address_3,
        ship_city,
        ship_state,
        ship_postal_code,
        ship_country,
        ship_phone_number,
        bill_address_1,
        bill_address_2,
        bill_address_3,
        bill_city,
        bill_state,
        bill_postal_code,
        bill_country,
        item_promotion_discount,
        ship_promotion_discount,
        carrier,
        tracking_number,
        estimated_arrival_date,
        fulfillment_center_id,
        fulfillment_channel,
        sales_channel,
        CURRENT_TIMESTAMP as updated_date,
        _daton_user_id,
        CAST(_daton_batch_runtime as int64) _daton_batch_runtime,
        _daton_batch_id,
        DENSE_RANK() OVER (PARTITION BY purchase_date, sku, amazon_order_id
        order by _daton_batch_runtime desc) row_num
        from {{i}} 
            {% if is_incremental() %}
            {# /* -- this filter will only be applied on an incremental run */ #}
            WHERE a._daton_batch_runtime  >= {{max_loaded}}
            --WHERE 1=1
            {% endif %}
    
        )
    where row_num =1 
    {% if not loop.last %} union all {% endif %}
{% endfor %}



