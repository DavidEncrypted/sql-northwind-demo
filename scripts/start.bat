@echo off
setlocal enabledelayedexpansion
echo Checking if port 3307 is available...
netstat -ano | findstr :3307 > nul
if not errorlevel 1 (
    echo Error: Port 3307 is already in use.
    echo Please stop any running MySQL instances first:
    echo   - For local MySQL: net stop mysql
    echo   - For Docker: docker stop $(docker ps -q --filter ancestor=mysql^)
    exit /b 1
)

echo Starting Northwind MySQL container...
docker-compose up -d

echo Waiting for MySQL to be ready...
set max_tries=30
set count=0
:check_mysql
docker exec northwind_mysql mysql -u root -pnorthwind -e "SELECT 1" >nul 2>&1
if errorlevel 1 (
    echo Waiting for MySQL to be ready... (!count!/%max_tries%^)
    timeout /t 2 /nobreak >nul
    set /a count+=1
    if !count! geq %max_tries% (
        echo Error: MySQL did not become ready in time
        exit /b 1
    )
    goto check_mysql
)
echo MySQL is ready!

echo Initializing database...
rem Run migrations in order (sorted numerically)
dir /B /O:N migrations\*.sql > migrations_list.tmp
for /F "tokens=*" %%f in (migrations_list.tmp) do (
    echo Running migration: migrations\%%f...
    docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/migrations/%%f"
)
del migrations_list.tmp

echo Loading sample data...
docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/seeds/northwind-data.sql"

echo Creating functions...
for %%f in (functions\*.sql) do (
    echo Loading %%f...
    docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/%%f"
)

echo Creating views...
for %%f in (views\*.sql) do (
    echo Loading %%f...
    docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/%%f"
)

echo Creating stored procedures...
for %%f in (procedures\*.sql) do (
    echo Loading %%f...
    docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/%%f"
)

echo.
echo Northwind database is ready!
echo Connection details:
echo   Host: localhost
echo   Port: 3307
echo   Database: northwind
echo   Username: root
echo   Password: northwind

echo Connecting to MySQL...
docker exec -it northwind_mysql mysql -u root -pnorthwind northwind
