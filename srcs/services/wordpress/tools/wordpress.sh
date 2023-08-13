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

# Set up php-fpm config
sed -i "s/{WORDPRESS_HOST}/$WORDPRESS_HOST/g" www.conf
sed -i "s/{WORDPRESS_PORT}/$WORDPRESS_PORT/g" www.conf

# Download wordpress files
for DOMAIN in $DOMAIN_NAMES; do
  mkdir -p /var/www/$DOMAIN_NAME
  wp core download --path=/var/www/$DOMAIN_NAME --allow-root
done

# Move php-fpm config file to its respective location
mv www.conf /etc/php/7.4/fpm/pool.d/