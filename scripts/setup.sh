#!/bin/bash

# Exit on error
set -e

echo "Setting up Northwind database..."

# Execute migrations in order
mysql < migrations/000_init.sql
mysql northwind < migrations/001_base_tables.sql
mysql northwind < migrations/002_lookup_tables.sql
mysql northwind < migrations/003_transaction_tables.sql
mysql northwind < migrations/004_order_details.sql

# Load original sample data
echo "Loading sample data..."
mysql northwind < seeds/northwind-data.sql

echo "Setup complete!"
