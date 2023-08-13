set -e
for DOMAIN in $DOMAINS; do
  if ! wp core is-installed --path=/var/www/$DOMAIN --allow-root; then
    echo "Installing and setting up wordpress for $DOMAIN..."
    # Set up wordpress config files
    DB_NAME="wp_$DOMAIN"
    DB_USER="user_$DOMAIN"
    DB_PASSWORD=abahhAWCNAWFUIBAwufgaoiHFUWfiahwgf
    wp config create --path=/var/www/$DOMAIN --allow-root \
      --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD \
      --dbhost=$MYSQL_HOST
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