# 🌱 Agri Intelligence

**Agricultural Retail Analytics using PySpark, Databricks and Delta Lake**

Agri Intelligence is a data engineering project that transforms agricultural retail sales data into structured business insights using the Medallion Architecture.

The project focuses on farmer purchase behaviour, seed product demand, village-level sales performance and monthly revenue trends.

## Project Objectives

- Understand farmer purchase history and spending patterns.
- Identify repeat purchasing behaviour.
- Analyse village-wise sales performance.
- Identify popular agricultural seed products.
- Track monthly revenue trends.

## Architecture

The project follows the Medallion Architecture.

```text
Source CSV Files
      |
      v
   Landing
      |
      v
   Bronze
  Raw Delta
      |
      v
   Silver
Cleaned Data
      |
      v
    Gold
Business Analytics
      |
      +--------------------+
      |                    |
      v                    v
 Farmer Memory        Village Pulse
```

## Technology Stack

| Technology | Purpose |
|---|---|
| Databricks Free Edition | Data engineering platform |
| Python | Programming language |
| PySpark | Distributed data processing |
| Delta Lake | Data storage |
| Unity Catalog | Data governance and management |
| GitHub | Source code version control |

## Dataset Overview

The project uses synthetic agricultural retail data.

| Dataset | Records |
|---|---:|
| Villages | 7 |
| Farmers | 100 |
| Products | 215 |
| Bills | 420 |
| Bill Items | 729 |

The dataset represents seven villages and multiple agricultural seed products.

There are 17 historical bills without identified farmer or village information. These records are retained without guessing customer identities.

## Medallion Layers

### Bronze Layer

Raw CSV ingestion into Delta tables.

- bronze_villages
- bronze_farmers
- bronze_products
- bronze_bills
- bronze_bill_items

### Silver Layer

Data cleaning and standardisation.

- silver_villages
- silver_farmers
- silver_products
- silver_bills
- silver_bill_items

### Gold Layer

Business-ready analytical tables.

**Farmer Memory**

- gold_farmer_summary
- gold_farmer_purchase_history
- gold_farmer_repeat_purchases
- gold_farmer_purchase_frequency

**Village Pulse**

- gold_village_summary
- gold_village_average_bill
- gold_village_top_products
- gold_monthly_revenue

**Shared analytical table**

- gold_sales

## Data Quality

The project includes checks for:

- Primary key uniqueness
- Missing primary keys
- Foreign key relationships
- Village master consistency
- Bill item calculation accuracy
- Bill header and item-level reconciliation

## Business Use Cases

**Farmer Memory**
- Farmer-level spending analysis
- Purchase history
- Repeat purchase identification
- Purchase frequency classification

**Village Pulse**
- Village-wise revenue
- Average bill value
- Top-selling seed products
- Monthly revenue trends

## Project Structure

```text
agri-intelligence/
├── README.md
├── notebooks/
│   ├── 01_bronze_ingestion.ipynb
│   ├── 02_silver_cleaning.ipynb
│   ├── 03_data_quality_checks.ipynb
│   └── 04_gold_business_model.ipynb
├── docs/
├── sql/
└── data/
    └── sample/
```

## Scope and Limitations

- Synthetic data is used throughout the project.
- This is a learning and analytics prototype.
- It does not replace billing software or integrate with Tally.
- Inventory management, stock availability and profit calculations are outside the current scope.
- No real farmer personal information is used.

## Future Enhancements

- Power BI dashboards
- Seasonal product demand analysis
- Inventory analytics using stock movement data
- Automated data ingestion
- Pipeline monitoring and logging

## Project Status

Core data ingestion, cleaning, quality validation and Gold analytical modelling have been implemented using Databricks, PySpark and Delta Lake.