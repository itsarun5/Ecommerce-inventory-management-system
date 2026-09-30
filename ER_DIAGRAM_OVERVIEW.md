# E-Commerce Inventory System: ER Diagram Overview

**Course:** CSE3001 Database Management Systems

## Overview

This project models the inventory side of an online store. Products are grouped into categories and bought from suppliers. Customers place orders, and each order contains one or more products. The ER diagram shows seven entities (tables) and how they connect, and `schema.sql` turns that diagram into MySQL tables.

## Tables

| Table | Purpose |
|---|---|
| Category | Groups products |
| Product | The items sold, with price, stock and reorder level |
| Supplier | Vendors who supply products |
| Product_Supplier | Links products to suppliers, with cost price and supply date |
| Customer | People who buy |
| Orders | One purchase by a customer, with date and status |
| Order_Item | The products inside an order, with quantity and unit price |

## Relationships

- **Category has Product (1:N):** one category holds many products, and each product belongs to one category. This is the foreign key `Product.category_id`.
- **Product supplied by Supplier (N:N):** a product can have many suppliers and a supplier can supply many products. A many-to-many link can't be stored directly, so it is split into the table `Product_Supplier`, whose primary key is (`product_id`, `supplier_id`).
- **Customer places Orders (1:N):** one customer can place many orders, and each order belongs to one customer. This is the foreign key `Orders.customer_id`.
- **Orders has Order_Item (1:N)** and **Product contains Order_Item (1:N):** an order can contain many products, and a product can appear in many orders, which is another many-to-many link. It is split into the table `Order_Item`, whose primary key is (`order_id`, `product_id`). `quantity` and `unit_price` are stored here because they describe one product inside one order.

## Why is it called "has"?

"has" is not a table. It is just the verb written inside the relationship diamond, so the diagram reads like a sentence: "a category **has** products" and "an order **has** items".

It appears twice in the diagram:

- **Category has Product:** this is a 1:N relationship, so it needs no table of its own. It is stored as the foreign key `category_id` inside `Product`.
- **Orders has Order_Item:** this is also 1:N, stored as the foreign key `order_id` inside `Order_Item`. `Order_Item` exists only because orders and products are many-to-many.

In short, 1:N relationships (like "has" and "places") become a foreign key, and only N:N relationships (like "supplied by") become a separate table.
