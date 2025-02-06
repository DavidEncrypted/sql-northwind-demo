#!/bin/bash

# Exit on error
set -e

echo "Resetting Northwind database..."

# Stop and remove containers, networks, volumes, and images created by docker-compose up
docker-compose down -v

# Start fresh
./scripts/start.sh
