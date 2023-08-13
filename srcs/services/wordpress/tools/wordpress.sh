set -e
# Install requirements for wordpress
apt-get install -y php-fpm php-mysql php-curl php-dom \
 php-imagick php-mbstring php-zip php-gd php-intl php-redis wget

# Install wp-cli
wget -O wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

mkdir -p /run/php
mkdir -p /etc/mysql

# Set up wordpress config files
sed -i "s/{DB_HOST}/$MYSQL_HOST/g" wp-config-template.php
for DOMAIN in $DOMAINS; do
  mkdir -p /var/www/$DOMAIN_NAME
  DB_NAME="wp_$DOMAIN"
  DB_USER="user_$DOMAIN"
  DB_PASSWORD=abahhAWCNAWFUIBAwufgaoiHFUWfiahwgf
  cp wp-config-template.php wp-config.php
  wget -O keys.txt https://api.wordpress.org/secret-key/1.1/salt/
  sed -i -e "/# INSERT SECRET KEYS HERE/r keys.txt" wp-config.php
  sed -i "s/{DB_NAME}/$DB_NAME/g" wp-config.php
  sed -i "s/{DB_USER}/$DB_USER/g" wp-config.php
  sed -i "s/{DB_PASSWORD}/$DB_PASSWORD/g" wp-config.php
  rm -rf keys.txt
  # Download wordpress files
  wp core download --path=/var/www/$DOMAIN_NAME --allow-root
  # Move wordprconfig file to its respective location
  mv wp-config.php /var/www/$DOMAIN_NAME/wp-config.php
done

# Set up php-fpm config
sed -i "s/{WORDPRESS_HOST}/$WORDPRESS_HOST/g" www.conf
sed -i "s/{WORDPRESS_PORT}/$WORDPRESS_PORT/g" www.conf

# Move php-fpm config file to its respective location
mv www.conf /etc/php/7.4/fpm/pool.d/