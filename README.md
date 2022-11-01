# Amazon Data Modelling
This DBT package models the Amazon API data coming from [Daton](https://sarasanalytics.com/daton/). Daton is the Unified Data Platform for Global Commerce with 100+ Pre-built connectors and data sets designed for commerce devloped by [Saras Analytics](https://sarasanalytics.com).

This package would be performing the following funtions:

- Consolidates the data from different brands and de duplicates and standardizes the data coming from Amazon.
- Adds descriptions to tables and columns that are synced using Daton
- Currency Conversion to ensure all the data is available at same currency level
- Models staging tables, which can be used directly as source for your BI tools/ Reports.

# Installation & Configuration

## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

Include in your `packages.yml`

```yaml
packages:
  - package: daton/amazon_source
    version: [">=0.1.0", "<0.3.0"]
```

## Models

This package contains transformation models from the Amazon API which includes Sponsored Brands, Products, Display and Selling Partner APIs. The primary outputs of this package are described below.

| **model**                 | **description**                                                                                                    |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| [FlatFileAllOrdersReportByLastUpdate](https://github.com/daton/dbt_amazon/blob/main/models/FlatFileAllOrdersReportByLastUpdate.sql)  | Table provides order level data |
| [FBAAmazonFulfilledShipmentsReport](https://github.com/daton/dbt_amazon/blob/main/models/FBAAmazonFulfilledShipmentsReport.sql)        | Table provides shipment level data.            |
| [stg_flatfileallorders](https://github.com/daton/dbt_amazon/blob/main/models/stg_flatfileallorders.sql)           | Each record represents an order, with additional dimensions like currency.           |  


# Configuration 

## Required Variables

This package assumes that you have an existing DBT project with a BigQuery profile connected & tested. Source data is located using the following variables which must be set in your `dbt_project.yml` file.

```
vars:
    project: "your_gcp_project"
    dataset: "your_amazon_sp_api_dataset"
```

## Optional Variables
### Table Exclusions

Setting these table exclusions will remove the modelling enabled for the below tables. By default, these tables are tagged True. 

```
vars:
    sp_flatfilev2settlement: True
    list_order: True
    fba_inventory_history_repor: True
    list_financial_events_order_fees: True
    list_financial_events_ordered_revenue: True
    list_financial_events_order_taxes: True 
    list_financial_events_order_promotions: True
    list_financial_events_refund_fees: True
    list_financial_events_refund_revnue: True
    list_financial_events_refund_taxes: True
    list_financial_events_refund_taxes: True
```

## Resources:
- Provide [feedback](XXXXX) on our existing dbt packages or what you'd like to see next
- Have questions, feedback, or need help? Book a time during our office hours [using Calendly](xxxx) or email us at xxxx@daton.com
- Learn more about Daton [here](https://sarasanalytics.com/daton/)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices