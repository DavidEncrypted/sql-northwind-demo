@echo off
echo Resetting Northwind database...

rem Stop and remove containers, networks, volumes, and images created by docker-compose up
docker-compose down -v

rem Start fresh
call scripts\start.bat
