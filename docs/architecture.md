# Agri Intelligence — Architecture

## 1. Project Overview

Agri Intelligence is an agricultural retail analytics project built using PySpark, Databricks, Delta Lake, and Unity Catalog.

The project transforms synthetic agricultural retail data into structured datasets for farmer purchase analysis and village-level business insights.

## 2. Technology Stack

| Component | Technology |
|---|---|
| Data Processing | PySpark |
| Data Platform | Databricks Free Edition |
| Storage Format | Delta Lake |
| Data Governance | Unity Catalog |
| Source Data | CSV |
| Version Control | Git and GitHub |

## 3. High-Level Architecture

```text
CSV Source Files
      |
      v
Unity Catalog Volume
      |
      v
Bronze Layer
(Raw Data Ingestion)
      |
      v
Silver Layer
(Data Cleaning and Standardization)
      |
      v
Data Quality Checks
      |
      v
Gold Layer
(Business-Level Data Models)
      |
      +----------------------+
      |                      |
      v                      v
Farmer Memory          Village Pulse
```

## 4. Source Data

The project uses five synthetic CSV datasets:

| Dataset | Records |
|---|---:|
| Villages | 7 |
| Farmers | 100 |
| Products | 215 |
| Bills | 420 |
| Bill Items | 729 |

Source files are stored in the Unity Catalog volume:

`/Volumes/workspace/agri_intelligence/landing/`

## 5. Medallion Architecture

### Bronze Layer

Purpose: Ingest source CSV files into Delta tables while retaining the raw data structure.

Tables:
- bronze_villages
- bronze_farmers
- bronze_products
- bronze_bills
- bronze_bill_items

### Silver Layer

Purpose: Clean, standardize, and prepare data for business-level processing.

Tables:
- silver_villages
- silver_farmers
- silver_products
- silver_bills
- silver_bill_items

### Data Quality

Data quality checks include:

- Primary key uniqueness
- Missing key validation
- Foreign key integrity
- Village name validation
- Bill item amount reconciliation
- Bill header and item total reconciliation

### Gold Layer

Purpose: Build business-ready datasets for analytical use cases.

**Shared dataset**
- gold_sales

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

Total: 9 Gold tables.

## 6. Business Use Cases

### Farmer Memory

Provides insights into:
- Farmer purchase history
- Total spending
- First and latest purchase dates
- Products purchased
- Repeat purchase patterns
- Purchase frequency

### Village Pulse

Provides insights into:
- Revenue by village
- Unique identified farmers
- Average bill value
- Top-selling products
- Monthly revenue trends
- Repeat farmer share

## 7. Data Handling Considerations

- The project uses synthetic data.
- Seventeen bills have no farmer or village identification.
- These bills remain included in overall sales analysis.
- Unidentified bills are excluded from farmer- and village-specific reporting.
- Missing identities are never guessed or assigned.

## 8. Scope and Limitations

This project focuses on historical sales analytics.

It does not currently implement:
- Live billing operations
- Inventory or stock-on-hand tracking
- Purchase and supplier management
- Profit calculations
- Real-time data ingestion
- Integration with external billing applications

## 9. Future Enhancements

Potential future improvements include:
- Automated data ingestion
- Incremental processing
- Pipeline orchestration
- Additional business dashboards
- Monitoring and operational logging

---

**Project:** Agri Intelligence  
**Platform:** Databricks  
**Architecture:** Medallion (Bronze, Silver, Gold)  
**Data Format:** Delta Lake  
**Repository:** https://github.com/SivaNR373/agri-intelligence
