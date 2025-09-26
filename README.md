# SQL-for-Data-Analysis
Here is SQL for Data Analysis which has been done in MySQL
This package contains the deliverables for Task 4 (SQL for Data Analysis) using
the Olist Customers dataset.
\\analysis_queries.sql
   - SQL script file containing all queries used in the analysis.
   - Covers:
     * Basic SELECT, WHERE, ORDER BY
     * GROUP BY with aggregates (COUNT, AVG)
     * Subqueries
     * CREATE VIEW for analysis
     * Index creation + EXPLAIN QUERY PLAN
     * Example JOIN queries (commented out, ready for use if other Olist tables are added)
\\Usage
1. Open `olist.db` in SQLite (or import CSV into MySQL/PostgreSQL).
2. Run the queries from `analysis_queries.sql`.
3. Compare results with screenshots in `sql_outputs/`.
4. Extend JOIN queries if other Olist tables (orders, order_items, products, sellers) are available.
\\Notes
- Indexing: An index on `customer_state` improves performance for GROUP BY and WHERE clauses on that column.
- JOIN queries are provided as templates; they require additional Olist tables.

Prepared by: [HANUSH MUNTHA]
Date: [26-09-2025]
