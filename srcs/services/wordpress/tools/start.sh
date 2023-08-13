set -e
for DOMAIN in $DOMAINS; do
  if ! wp core is-installed --path=/var/www/$DOMAIN --allow-root; then
    echo "Installing and setting up wordpress for $DOMAIN..."
    # Set up wordpress config file
    cp wp-config-template.php wp-config.php
    sed -i "s/DB_NAME/$DB_NAME/g" wp-config.php
    sed -i "s/DB_USER/$DB_USER/g" wp-config.php
    sed -i "s/DB_PASSWORD/$DB_PASSWORD/g" wp-config.php
    sed -i "s/DB_HOST/$MYSQL_HOST/g" wp-config.php
    mv wp-config.php /var/www/$DOMAIN
    # Install wordpress site
    wp core install --path=/var/www/$DOMAIN --allow-root \
    --url="https://$DOMAIN" --title="placeholder" --admin_user="lol" \
    --admin_password="abahhAWCNAWFUIBAwufgaoiHFUWfiahwgf" --admin_email=none@none.com
    # Set up files permissions for wordpress
    chown -R www-data:www-data /var/www/$DOMAIN
    find /var/www/$DOMAIN -type d -exec chmod 755 {} \;
    find /var/www/$DOMAIN -type f -exec chmod 644 {} \;
  fi
done

echo "Wordpress started!"
/usr/sbin/php-fpm7.4 -F