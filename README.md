# MyWind
Forked from: github.com/dalers/mywind
---

MyWind is a MySQL version of the Microsoft Access 2010 *Northwind* sample database. The database provides an excellent tutorial schema for a small business, managing customers, orders, inventory, purchasing, suppliers, shipping, and employees.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

That's it! No need to install MySQL locally.

## Quick Start

1. Clone this repository:
   ```bash
   git clone [repository-url]
   cd [repository-name]
   ```

2. Start the database (choose one based on your OS):
   ```bash
   # Linux/macOS
   ./scripts/start.sh

   # Windows
   scripts\start.bat
   ```

The script will:
- Start a Docker container with MySQL
- Initialize the Northwind database
- Load sample data
- Create stored procedures
- Connect you to the database
  - Any changes you make to files in the directory are mounted in the docker container. So you can update for example stored procedures with a normal mysql command in the terminal

## Connection Details

Once started, you can connect to the database using:
- Host: localhost
- Port: 3307
- Database: northwind
- Username: root
- Password: northwind

## Available Scripts

### Linux/macOS
```bash
./scripts/start.sh   # Start the database
./scripts/stop.sh    # Stop the database
./scripts/reset.sh   # Reset to initial state
```

### Windows
```cmd
scripts\start.bat   # Start the database
scripts\stop.bat    # Stop the database
scripts\reset.bat   # Reset to initial state
```

## Project Structure

```
sql_demo/
├── docker/              # Docker configuration
│   ├── Dockerfile      # MySQL container configuration
│   └── init/          # Initialization scripts
├── migrations/         # Database schema files
│   ├── 000_init.sql   # Database initialization
│   ├── 001_base_tables.sql     # Core tables
│   ├── 002_lookup_tables.sql   # Status and type tables
│   ├── 003_transaction_tables.sql  # Orders and inventory
│   └── 004_order_details.sql   # Order details
├── seeds/             # Sample data
│   └── northwind-data.sql    # Original Northwind sample data
├── functions/         # Database functions
├── procedures/        # Stored procedures
├── views/            # Database views
├── scripts/          # Utility scripts
│   ├── start.sh      # Start database (Linux/macOS)
│   ├── start.bat     # Start database (Windows)
│   ├── stop.sh       # Stop database (Linux/macOS)
│   ├── stop.bat      # Stop database (Windows)
│   ├── reset.sh      # Reset database (Linux/macOS)
│   └── reset.bat     # Reset database (Windows)
└── docs/             # Documentation
    ├── erd/          # Entity Relationship Diagrams
    │   ├── northwind-erd.pdf
    │   └── northwind-erd.png
    └── models/       # Database models
        └── northwind.mwb
```

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

## Using the Database

You can analyze the data using the provided stored procedures:

```sql
-- Show total orders per year
CALL orders_per_year_report();

-- Show orders per month for a specific year
CALL orders_per_month_report(2006);

-- Show sales performance over a time period
CALL generate_sales_performance_report('2005-01-01 00:00:00', '2007-01-31 23:59:59', 'DETAILED');
```

## Troubleshooting

1. If the container fails to start:
   - Check if ports are available: `netstat -an | grep 3307`
   - Ensure Docker is running
   - Try stopping any existing MySQL instances

2. If you can't connect to the database:
   - Ensure the container is running: `docker ps`
   - Check container logs: `docker logs northwind_mysql`
   - Verify no other services are using port 3307

3. To completely reset the setup:
   ```bash
   # Linux/macOS
   ./scripts/reset.sh

   # Windows
   scripts\reset.bat
   ```

## Running MySQL Commands

When the database is running, you can execute MySQL commands in several ways:

1. Using Docker directly:
   ```bash
   # Interactive MySQL shell
   docker exec -it northwind_mysql mysql -u root -pnorthwind northwind

   # Run a single command
   docker exec -it northwind_mysql mysql -u root -pnorthwind northwind -e "SELECT * FROM customers"

   # Execute a SQL file
   docker exec -it northwind_mysql mysql -u root -pnorthwind northwind < your-query.sql
   ```

2. When connected to the mysql server after running the start script
   ```

Note: The password warning message can be safely ignored when using these commands.

## Files

* Model:
    * docs/models/northwind.mwb (MySQL Workbench v6.2)
* EER Diagram:
    * docs/erd/northwind-erd.pdf
    * docs/erd/northwind-erd.png
