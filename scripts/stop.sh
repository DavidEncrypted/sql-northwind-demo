#!/bin/bash

# Exit on error
set -e

echo "Stopping Northwind MySQL container..."
docker-compose down

echo "Container stopped successfully!"
