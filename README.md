# Adventure Works Sales - Analytics Engineer Formation

This dbt project transforms the Adventure Works transactional dataset into a
tested, documented, and business-ready analytics layer for consumption by BI
tools and reporting applications.

The project supports analysis of orders, purchased quantities, gross revenue,
discounts, net transaction value, customers, products, card types, sales
reasons, order status, dates, and delivery locations. Its main analytical output
is an enriched order-detail mart for time series, rankings, and filtered sales
dashboards.

## Architecture

The project follows a layered dbt architecture:

```text
Adventure Works sources
        |
        v
staging views
        |
        v
intermediate views
        |
        v
gold facts and dimensions
        |
        v
enriched analytical mart
```

### Staging

The `models/staging` layer provides one-to-one representations of source
entities. It handles column renaming, basic type casting, and source
standardization. Models are organized by the `person`, `product`, and `sales`
domains and are materialized as views.

Naming convention: `stg_<source>__<entities>`.

Example: `stg_sales__order_headers`.

### Intermediate

The `models/intermediate` layer contains reusable business transformations and
joins. Examples include sales order-detail calculations, customer address
enrichment, and sales-reason aggregation. These models are materialized as
views.

- `int__sales_order_details`: one row per sales order detail;
- `int__sales_order_reasons`: one row per order and sales reason;
- `int__sales_order_reasons_aggregated`: one row per sales order;
- `int_client__addresses`: one row per address.

### Gold

The `models/gold` layer contains business-ready facts, dimensions, bridges, and
marts. These models are materialized as tables.

| Model | Grain |
| --- | --- |
| `gold__fact_sales_orders` | One row per sales order |
| `gold__fact_sales_order_details` | One row per sales order detail |
| `gold__dim_customers` | One row per customer |
| `gold__dim_products` | One row per product |
| `gold__dim_credit_cards` | One row per credit card |
| `gold__dim_delivery_addresses` | One row per delivery address |
| `gold__dim_sales_reasons` | One row per sales reason |
| `gold__bridge_sales_order_reasons` | One row per order and sales reason |
| `gold__dim_sales_reasons_by_order_id` | One row per sales order |
| `mart__sales_order_details_enriched` | One row per sales order detail |

## Main Analytical Mart

`mart__sales_order_details_enriched` is the primary consumption model. It
combines order-detail metrics with customer, product, card, sales-reason, order
status, date, and delivery-location attributes.

Its detail-level grain allows consumers to calculate metrics at different
levels without separate pre-aggregated marts:

- order count: `count(distinct sales_order_id)`;
- purchased quantity: `sum(order_qty)`;
- gross revenue: `sum(gross_amount)`;
- product discounts: `sum(discount_amount)`;
- net transaction value: `sum(net_amount)`;
- average order value: `sum(net_amount) / count(distinct sales_order_id)`.

Sales reasons have a many-to-many relationship with orders. They are aggregated
into arrays before being joined to the mart, preserving the order-detail grain
and preventing duplicated quantities and financial metrics. In SQL engines
that support arrays, a specific reason can be filtered with:

```sql
array_contains(sales_reason_names, 'Promotion')
```

The bridge model remains available when an analysis requires one row per order
and sales reason.

## Data Quality

Model documentation is stored in domain-level `schema` directories, while unit
tests are organized in `unit_tests` directories. The project includes:

- primary-key uniqueness and not-null tests;
- relationship tests between facts and dimensions;
- accepted-value tests for controlled attributes;
- unit tests for renaming, joins, business rules, aggregations, and financial
  calculations.

## Running the Project

Configure the `dbt_fabio` profile in `~/.dbt/profiles.yml`, then run:

```bash
dbt debug
dbt build
```

Useful scoped commands:

```bash
dbt build --select path:models/staging
dbt build --select path:models/intermediate
dbt build --select +path:models/gold
dbt test --select resource_type:unit_test
```

## Project Structure

```text
models/
├── staging/
│   ├── person/
│   ├── product/
│   └── sales/
├── intermediate/
│   ├── client/
│   └── sales/
└── gold/
    ├── marts/
    ├── other/
    ├── product/
    └── sales/
```
