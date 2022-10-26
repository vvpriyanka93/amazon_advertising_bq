# Amazon Data Modelling
This  package models the Amazon API data coming from the [Daton's connector] (https://daton.sarasanalytics.com/) by combining the data from different brands and de duplicating the existing data.

This package would be performing the following funtions:

Adds descriptions to tables and columns that are synced using Daton
Models staging tables, which can be used directly as source for your BI tools/ Reports.

# Installation & Configuration

## Install From GitHub

Add the following to your `packages.yml` file:

```
packages:
  - git: "https://github.com/Saras/dbt_amazon.git"
    revision: 1.0.0
```

## Install From Local Directory

1. Clone this repository to a folder in the same parent directory as your DBT project
2. Update your project's `packages.yml` to include a reference to this package:

```
packages:
  - local: ../dbt_amazon
```
## Required Variables

This package assumes that you have an existing DBT project with a BigQuery profile connected & tested. Source data is located using the following variables which must be set in your `dbt_project.yml` file.

```
vars:
    project: "your_gcp_project"
    dataset: "your_amazon_sp_api_dataset"
```

## Optional Variables
### Table Exclusions

Setting these table exclusions will remove the modelling enabled for these tables. By default, these tables are tagged True. 

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
- Learn more about Daton [in our docs](XXX)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices