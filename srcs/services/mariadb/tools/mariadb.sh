set -e
# Install requirements for mariadb
apt-get install -y mariadb-server

# Move config files to their respective locations
mv 50-server.cnf /etc/mysql/mariadb.conf.d/

# Set permissions for mariadb config file
chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

# Set up mariadb setup script
sed -i "s/{MYSQL_ROOT_PW}/$MYSQL_ROOT_PW/g" setup_mariadb.sql

# Start and setup mariadb
/etc/init.d/mariadb start
mariadb < setup_mariadb.sql

mkdir -p /credentials/mysql
DB_NAME=$(grep "DB_NAME=" /mysql/mysql.secret | cut -d'=' -f2)
DB_USER=$(grep "DB_USER=" /mysql/mysql.secret | cut -d'=' -f2)
PASSWORD=$(grep "DB_PASSWORD=" /mysql/mysql.secret | cut -d'=' -f2)
cp create_database_template.sql create_database.sql
sed -i "s/{MYSQL_DATABASE}/$DB_NAME/g" create_database.sql
sed -i "s/{MYSQL_USER}/$DB_USER/g" create_database.sql
sed -i "s/{MYSQL_USER_PW}/$PASSWORD/g" create_database.sql
mariadb < create_database.sql
rm -rf create_database.sql

rm -rf setup_mariadb.sql mysql
