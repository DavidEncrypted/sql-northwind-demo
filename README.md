# MyWind

MyWind is a MySQL version of the Microsoft Access 2010 *Northwind* sample database.

The Northwind sample database provided with Microsoft Access is an excellent tutorial schema for a small business to manage customers, orders, inventory, purchasing, suppliers, shipping, and employees, using single-entry accounting.

## Project Structure

```
sql_demo/
├── migrations/           # Database schema files
│   ├── 000_init.sql     # Database initialization
│   ├── 001_base_tables.sql     # Core tables (customers, employees, products)
│   ├── 002_lookup_tables.sql   # Status and type tables
│   ├── 003_transaction_tables.sql  # Orders and inventory
│   └── 004_order_details.sql   # Order details and related tables
├── seeds/               # Sample data
│   └── northwind-data.sql      # Original Northwind sample data
├── functions/           # Database functions (for future use)
├── procedures/          # Stored procedures (for future use)
├── views/              # Database views (for future use)
├── scripts/            # Utility scripts
│   ├── setup.sh        # Database creation script
│   └── reset.sh        # Clean and rebuild script
└── docs/               # Documentation
    ├── erd/            # Entity Relationship Diagrams
    │   ├── northwind-erd.pdf
    │   └── northwind-erd.png
    └── models/         # Database models
        └── northwind.mwb

## Setup Instructions

1. Ensure you have MySQL installed and running
2. Make the scripts executable (if not already):
   ```bash
   chmod +x scripts/*.sh
   ```
3. Run the setup script:
   ```bash
   ./scripts/setup.sh
   ```

To reset the database to its original state:
```bash
./scripts/reset.sh
```

## Files

* Model:
    * docs/models/northwind.mwb (MySQL Workbench v6.2)
* EER Diagram:
    * docs/erd/northwind-erd.pdf
    * docs/erd/northwind-erd.png
* Structure:
    * migrations/*.sql (Split into logical components)
* Data:
    * seeds/northwind-data.sql

## Sample Data Overview

The database contains sample data from 2006, including:
- Total orders per year: 48 orders in 2006
- Monthly distribution:
  - January: 4 orders
  - February: 3 orders
  - March: 8 orders
  - April: 17 orders
  - May: 8 orders
  - June: 8 orders

You can analyze this data using the provided stored procedures:
```sql
CALL orders_per_year_report();    -- Shows total orders per year
CALL orders_per_month_report(2006);  -- Shows orders per month for a specific year
```
