-- =========================================================
-- AGRI INTELLIGENCE
-- Business Queries
-- Platform: Databricks SQL
-- Architecture: Medallion (Bronze, Silver, Gold)
-- =========================================================


-- =========================================================
-- 1. FARMER MEMORY
-- =========================================================

-- 1.1 Farmer purchase summary
SELECT
    farmer_id,
    farmer_name,
    village_name,
    total_bills,
    total_spent_inr,
    first_purchase_date,
    last_purchase_date,
    different_varieties,
    customer_type
FROM workspace.agri_intelligence.gold_farmer_summary
ORDER BY total_spent_inr DESC;


-- 1.2 Farmer purchase history by product
SELECT
    farmer_id,
    farmer_name,
    village_name,
    product_display_name,
    crop,
    total_packs_purchased,
    total_spent_inr
FROM workspace.agri_intelligence.gold_farmer_purchase_history
ORDER BY farmer_id, total_spent_inr DESC;


-- 1.3 Repeat purchases by farmer and product
SELECT
    farmer_id,
    farmer_name,
    village_name,
    product_display_name,
    purchase_count,
    total_packs_purchased,
    total_spent_inr
FROM workspace.agri_intelligence.gold_farmer_repeat_purchases
ORDER BY purchase_count DESC, total_spent_inr DESC;


-- 1.4 Farmer purchase frequency
SELECT
    farmer_id,
    farmer_name,
    village_name,
    total_bills,
    total_spent_inr,
    customer_type,
    purchase_frequency
FROM workspace.agri_intelligence.gold_farmer_purchase_frequency
ORDER BY total_bills DESC;


-- 1.5 Overall repeat farmer share
-- Denominator: identified farmers in gold_farmer_summary
SELECT
    COUNT(*) AS total_identified_farmers,
    SUM(CASE WHEN total_bills > 1 THEN 1 ELSE 0 END)
        AS repeat_farmers,
    ROUND(
        100.0 * SUM(CASE WHEN total_bills > 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_farmer_share_pct
FROM workspace.agri_intelligence.gold_farmer_summary;


-- =========================================================
-- 2. VILLAGE PULSE
-- =========================================================

-- 2.1 Village business summary
SELECT
    village_name,
    total_revenue_inr,
    unique_farmers,
    total_bills,
    average_item_value_inr
FROM workspace.agri_intelligence.gold_village_summary
WHERE village_name IS NOT NULL
ORDER BY total_revenue_inr DESC;


-- 2.2 Average bill value by village
SELECT
    village_name,
    average_bill_value_inr
FROM workspace.agri_intelligence.gold_village_average_bill
ORDER BY average_bill_value_inr DESC;


-- 2.3 Top products by village
SELECT
    village_name,
    product_display_name,
    crop,
    total_packs_sold,
    total_revenue_inr,
    product_rank
FROM workspace.agri_intelligence.gold_village_top_products
WHERE product_rank <= 5
ORDER BY village_name, product_rank;


-- 2.4 Monthly revenue trend
SELECT
    sales_month,
    total_revenue_inr
FROM workspace.agri_intelligence.gold_monthly_revenue
ORDER BY sales_month;


-- =========================================================
-- 3. SHARED SALES ANALYSIS
-- =========================================================

-- 3.1 Overall sales performance
SELECT
    COUNT(DISTINCT bill_id) AS total_bills,
    COUNT(DISTINCT bill_item_id) AS total_bill_items,
    SUM(quantity_packs) AS total_packs_sold,
    SUM(line_total_inr) AS total_revenue_inr
FROM workspace.agri_intelligence.gold_sales;


-- 3.2 Top-selling products
SELECT
    product_display_name,
    SUM(quantity_packs) AS total_packs_sold,
    SUM(line_total_inr) AS total_revenue_inr
FROM workspace.agri_intelligence.gold_sales
GROUP BY product_display_name
ORDER BY total_packs_sold DESC;


-- 3.3 Sales by crop
SELECT
    crop,
    SUM(quantity_packs) AS total_packs_sold,
    SUM(line_total_inr) AS total_revenue_inr
FROM workspace.agri_intelligence.gold_sales
GROUP BY crop
ORDER BY total_revenue_inr DESC;


-- 3.4 Sales by village
SELECT
    village_name,
    COUNT(DISTINCT bill_id) AS total_bills,
    SUM(quantity_packs) AS total_packs_sold,
    SUM(line_total_inr) AS total_revenue_inr
FROM workspace.agri_intelligence.gold_sales
WHERE village_name IS NOT NULL
GROUP BY village_name
ORDER BY total_revenue_inr DESC;


-- 3.5 Monthly sales trend from sales transactions
SELECT
    date_format(bill_date, 'yyyy-MM') AS sales_month,
    SUM(line_total_inr) AS monthly_revenue_inr
FROM workspace.agri_intelligence.gold_sales
GROUP BY date_format(bill_date, 'yyyy-MM')
ORDER BY sales_month;


-- 3.6 Sales by company
SELECT
    company_name,
    SUM(quantity_packs) AS total_packs_sold,
    SUM(line_total_inr) AS total_revenue_inr
FROM workspace.agri_intelligence.gold_sales
GROUP BY company_name
ORDER BY total_revenue_inr DESC;


-- =========================================================
-- END OF BUSINESS QUERIES
-- =========================================================