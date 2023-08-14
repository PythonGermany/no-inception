set -e
for DOMAIN in $DOMAINS; do
  if ! wp core is-installed --path=/var/www/$DOMAIN --allow-root; then
    echo "Installing and setting up wordpress for $DOMAIN..."
    # Set up wordpress config file
    cp wp-config-template.php wp-config.php
    DB_NAME=$(grep "$DOMAIN" /credentials/mysql/$DOMAIN.txt | cut -d' ' -f2)
    DB_USER=$(grep "$DOMAIN" /credentials/mysql/$DOMAIN.txt | cut -d' ' -f3)
    DB_PASSWORD=$(grep "$DOMAIN" /credentials/mysql/$DOMAIN.txt | cut -d' ' -f4)
    wget -O keys.txt https://api.wordpress.org/secret-key/1.1/salt/
    sed -i -e "/# INSERT SECRET KEYS HERE/r keys.txt" wp-config.php
    rm -rf keys.txt
    sed -i "s/{DB_NAME}/$DB_NAME/g" wp-config.php
    sed -i "s/{DB_USER}/$DB_USER/g" wp-config.php
    sed -i "s/{DB_PASSWORD}/$DB_PASSWORD/g" wp-config.php
    sed -i "s/{DB_HOST}/$MYSQL_HOST/g" wp-config.php
    mv wp-config.php /var/www/$DOMAIN
    # Install wordpress site
    WP_TITLE=$(grep "WP_TITLE=" /wp_default_config/$DOMAIN.keys | cut -d'=' -f2)
    WP_ADMIN=$(grep "WP_ADMIN=" /wp_default_config/$DOMAIN.keys | cut -d'=' -f2)
    WP_ADMIN_PW=$(grep "WP_ADMIN_PW=" /wp_default_config/$DOMAIN.keys | cut -d'=' -f2)
    WP_ADMIN_EMAIL=$(grep "WP_ADMIN_EMAIL=" /wp_default_config/$DOMAIN.keys | cut -d'=' -f2)
    wp core install --path=/var/www/$DOMAIN --allow-root \
    --url="https://$DOMAIN" --title=$WP_TITLE --admin_user=$WP_ADMIN \
    --admin_password=$WP_ADMIN_PW --admin_email=$WP_ADMIN_EMAIL
    rm -f /wp_default_config/$DOMAIN.keys
    #  Set up files permissions for wordpress
    chown -R www-data:www-data /var/www/$DOMAIN
    find /var/www/$DOMAIN -type d -exec chmod 755 {} \;
    find /var/www/$DOMAIN -type f -exec chmod 644 {} \;
  fi
done

echo "Wordpress started!"
/usr/sbin/php-fpm7.4 -F
