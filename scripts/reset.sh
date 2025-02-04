#!/bin/bash

# Exit on error
set -e

echo "Resetting Northwind database..."

# Drop and recreate database
mysql -e "DROP DATABASE IF EXISTS northwind;"

# Run setup script
./setup.sh

echo "Reset complete!"
