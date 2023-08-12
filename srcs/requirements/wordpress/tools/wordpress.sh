# Install requirements for wordpress
apt-get install -y php-fpm php-mysql php-curl php-dom \
 php-imagick php-mbstring php-zip php-gd php-intl php-redis wget && \

mkdir -p /var/www/$DOMAIN_NAME && \
mkdir -p /run/php && \
mkdir -p /etc/mysql && \

# Set up wordpress config
wget -O keys.txt https://api.wordpress.org/secret-key/1.1/salt/ && \
sed -i -e "/# INSERT SECRET KEYS HERE/r keys.txt" wp-config.php && \
sed -i "s/{DB_NAME}/$MYSQL_DATABASE/g" wp-config.php && \
sed -i "s/{DB_USER}/$MYSQL_USER/g" wp-config.php && \
sed -i "s/{DB_PASSWORD}/$MYSQL_USER_PW/g" wp-config.php && \
sed -i "s/{DB_HOST}/$MYSQL_HOST/g" wp-config.php && \
sed -i "s/{WP_REDIS_PREFIX}/$DOMAIN_NAME/g" wp-config.php && \
sed -i "s/{WORDPRESS_HOST}/$WORDPRESS_HOST/g" www.conf && \
sed -i "s/{WORDPRESS_PORT}/$WORDPRESS_PORT/g" www.conf && \
sed -i "s/{REDIS_HOST}/$REDIS_HOST/g" wp-config.php && \
sed -i "s/{REDIS_PORT}/$REDIS_PORT/g" wp-config.php && \
sed -i "s/{REDIS_PASSWORD}/$REDIS_PW/g" wp-config.php && \
rm -rf keys.txt && \

# Install wp-cli
wget -O wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
chmod +x wp-cli.phar && \
mv wp-cli.phar /usr/local/bin/wp && \

# Download wordpress files
wp core download --path=/var/www/$DOMAIN_NAME --allow-root && \

# Download adminer file
wget -O /var/www/$DOMAIN_NAME/$ADMINER_FILE_NAME https://www.adminer.org/latest.php && \

# Move config files to their respective locations
mv wp-config.php /var/www/$DOMAIN_NAME/ && \
mv www.conf /etc/php/7.4/fpm/pool.d/