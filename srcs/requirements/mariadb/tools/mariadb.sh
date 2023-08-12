# Install requirements for mariadb
apt-get install -y mariadb-server && \

# Move config files to their respective locations
mv 50-server.cnf /etc/mysql/mariadb.conf.d/ && \

# Set permissions for mariadb config file
chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf && \

# Set up mariadb initialization script
sed -i "s/{MYSQL_ROOT_PW}/$MYSQL_ROOT_PW/g" create_database.sql && \
sed -i "s/{MYSQL_DATABASE}/$MYSQL_DATABASE/g" create_database.sql && \
sed -i "s/{MYSQL_USER}/$MYSQL_USER/g" create_database.sql && \
sed -i "s/{MYSQL_USER_PW}/$MYSQL_USER_PW/g" create_database.sql && \

# Start and initialize mariadb
/etc/init.d/mariadb start && \
mariadb < create_database.sql && \

rm -rf create_database.sql