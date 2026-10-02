# E-commerce Inventory System

A relational database project for **CSE3001 - Database Management Systems** (VIT Bhopal), modeling inventory, suppliers, customers, and orders for a single-location e-commerce store.

## Schema Overview

| Table            | Purpose                                              |
|------------------|-------------------------------------------------------|
| `Category`       | Product categories                                    |
| `Product`        | Inventory items, price, stock level, reorder threshold |
| `Supplier`       | Suppliers                                              |
| `Product_Supplier` | Resolves M:N between Product and Supplier (cost, date) |
| `Customer`       | Customers                                              |
| `Orders`         | Customer orders (date, status)                         |
| `Order_Item`     | Resolves M:N between Orders and Product (line items)   |

All tables are normalized to 3NF/BCNF — no partial or transitive dependencies.

### Entity-Relationship Summary
- `Category` (1) —— (N) `Product`
- `Product` (M) —— (N) `Supplier` via `Product_Supplier`
- `Customer` (1) —— (N) `Orders`
- `Orders` (M) —— (N) `Product` via `Order_Item`

## Files
- `schema.sql` — table definitions, constraints, indexes
- `sample_data.sql` — sample rows for all tables
- `triggers_and_views.sql` — stock-management triggers + reporting views
- `queries.sql` — example SELECT queries (joins, aggregation, subqueries)

## Setup

```bash
mysql -u root -p < schema.sql
mysql -u root -p < sample_data.sql
mysql -u root -p < triggers_and_views.sql
mysql -u root -p ecommerce_inventory < queries.sql
```

## Features
- **Triggers**: stock auto-decrements when an order item is placed; an order is rejected if requested quantity exceeds available stock.
- **Views**: `vw_low_stock_products` (reorder alerts), `vw_order_summary` (per-order totals).
- **Constraints**: CHECK constraints on price/quantity, foreign keys with appropriate ON DELETE/UPDATE actions, composite keys for junction tables.

### MANAGED BY 
- Tanuj Tanmay Patel 25bce11280
- Hemil Shah 25bce10124
- Prashant Taparia 25bce11043
- Arun Kumar 25bce11009
