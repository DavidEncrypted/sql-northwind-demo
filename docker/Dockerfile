FROM mysql:8.0

# Set default authentication plugin
RUN echo "[mysqld]" >> /etc/mysql/conf.d/docker.cnf \
    && echo "default_authentication_plugin=mysql_native_password" >> /etc/mysql/conf.d/docker.cnf

# Create directory for initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d

WORKDIR /docker-entrypoint-initdb.d
