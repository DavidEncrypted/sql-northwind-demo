#!/bin/bash

# Exit on error
set -e

echo "Checking if port 3307 is available..."
if lsof -i :3307 > /dev/null 2>&1; then
    echo "Error: Port 3307 is already in use."
    echo "Please stop any running MySQL instances first:"
    echo "  - For local MySQL: sudo service mysql stop"
    echo "  - For Docker: docker stop $(docker ps -q --filter ancestor=mysql)"
    exit 1
fi

echo "Starting Northwind MySQL container..."
docker-compose up -d

echo "Waiting for MySQL to be ready..."
max_tries=30
count=0
while ! docker exec northwind_mysql mysql -u root -pnorthwind -e "SELECT 1" >/dev/null 2>&1; do
    echo "Waiting for MySQL to be ready... ($count/$max_tries)"
    sleep 2
    count=$((count + 1))
    if [ $count -ge $max_tries ]; then
        echo "Error: MySQL did not become ready in time"
        exit 1
    fi
done
echo "MySQL is ready!"

echo "Initializing database..."
# Run migrations in order (sorted numerically)
find migrations -name "*.sql" -type f | sort -V | while read -r migration; do
    echo "Running migration: $migration..."
    docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/$migration"
done

# Load sample data
echo "Loading sample data..."
docker exec northwind_mysql bash -c 'mysql -u root -pnorthwind northwind < /app/seeds/northwind-data.sql'

# Create functions
echo "Creating functions..."
for func in functions/*.sql; do
    if [ -f "$func" ]; then
        echo "Loading $func..."
        docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/$func"
    fi
done

# Create views
echo "Creating views..."
for view in views/*.sql; do
    if [ -f "$view" ]; then
        echo "Loading $view..."
        docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/$view"
    fi
done

# Create stored procedures
echo "Creating stored procedures..."
for sp in procedures/*.sql; do
    if [ -f "$sp" ]; then
        echo "Loading $sp..."
        docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/$sp"
    fi
done

echo "Northwind database is ready!"
echo "Connection details:"
echo "  Host: localhost"
echo "  Port: 3307"
echo "  Database: northwind"
echo "  Username: root"
echo "  Password: northwind"

echo "Database is ready! To connect, run:"
echo "  ./scripts/connect.sh"
