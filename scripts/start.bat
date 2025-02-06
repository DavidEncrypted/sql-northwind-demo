@echo off
setlocal enabledelayedexpansion

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
    docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/functions/%%~nxf"
)

echo Creating views...
for %%f in (views\*.sql) do (
    echo Loading %%f...
    docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/views/%%~nxf"
)

echo Creating stored procedures...
for %%f in (procedures\*.sql) do (
    echo Loading %%f...
    docker exec northwind_mysql bash -c "mysql -u root -pnorthwind northwind < /app/procedures/%%~nxf"
)

echo.
echo Northwind database is ready!
echo Connection details:
echo   Host: localhost
echo   Port: 3307
echo   Database: northwind
echo   Username: root
echo   Password: northwind

echo Database is ready! To connect, run:
echo   scripts\connect.bat
