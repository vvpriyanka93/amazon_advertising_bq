# Amazon Data Modelling
This DBT package models the Amazon Adverstising data coming from [Daton](https://sarasanalytics.com/daton/). [Daton](https://sarasanalytics.com/daton/) is the Unified Data Platform for Global Commerce with 100+ pre-built connectors and data sets designed for accelerating the eCommerce data and analytics journey by [Saras Analytics](https://sarasanalytics.com).

This package would be performing the following funtions:

- Consolidates and de duplicates the advertising data coming from Amazon Ads API.
- Adds descriptions to tables and columns that are synced using Daton
- Currency Conversion to ensure all the data is available at same currency level
- Time Zone Conversion

# Installation & Configuration

## Installation Instructions

If you haven't already, you will need to create a packages.yml file in your project. Include this in your `packages.yml` file

```yaml
packages:
  - package: daton/amazon_adverstising_bq
    version: [">=0.1.0", "<0.3.0"]
```

## Models

This package contains models from the Amazon API which includes Sponsored Brands, Products, Display. The primary outputs of this package are described below.

| **Category**                 | **Model**  | **Description** |
| ------------------------- | ---------------| ----------------------- |
|Sponsored Brands | [SponsoredBrands_AdGroupsReport](https://github.com/daton/amazon_advertising/blob/main/models/SponsoredBrands_AdGroupsReport.sql)  | A list of ad groups associated with the account |
|Sponsored Brands | [SponsoredBrands_AdGroupsVideoReport](https://github.com/daton/amazon_advertising/blob/main/models/SponsoredBrands_AdGroupsVideoReport.sql)| A list of ad groups related to sponsored brand video associated with the account |
|Sponsored Brands | [SponsoredBrands_PlacementCampaignsReport](https://github.com/daton/amazon_advertising/blob/main/models/SponsoredBrands_PlacementCampaignsReport.sql)| A list of all the placement campaigns associated with the account |
|Sponsored Brands | [SponsoredBrands_SearchTermKeywordsReport](https://github.com/daton/amazon_advertising/blob/main/models/SponsoredBrands_SearchTermKeywordsReport.sql)| A list of product search keywords report |
|Sponsored Brands | [SponsoredBrands_SearchTermKeywordsVideoReport](https://github.com/daton/amazon_advertising/blob/main/models/SponsoredBrands_SearchTermKeywordsVideoReport.sql)| A list of keywords associated with sponsored brand video |
|Sponsored Display | [SponsoredDisplay_ProductAdsReport](https://github.com/daton/amazon_advertising/blob/main/models/SponsoredDisplay_ProductAdsReport.sql)| A list of product ads associated with the account |
|Sponsored Products | [SponsoredProducts_PlacementCampaignsReport](https://github.com/daton/amazon_advertising/blob/main/models/SponsoredProducts_PlacementCampaignsReport.sql)| A list of all the placement campaigns associated with the account |
|Sponsored Products | [SponsoredProducts_ProductAdsReport](https://github.com/daton/amazon_advertising/blob/main/models/SponsoredProducts_ProductAdsReport.sql)| A list of product ads associated with the account |
|Sponsored Products | [SponsoredProducts_SearchTermKeywordReport](https://github.com/daton/amazon_advertising/blob/main/models/SponsoredProducts_SearchTermKeywordReport.sql)| A list of product search keywords report |

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
- Have questions, feedback, or need [help](https://meetings.hubspot.com/balaji-kolli/)? Schedule a call with our data experts or email us at info@sarasanalytics.com.
- Learn more about Daton [here]().