set -e
for DOMAIN in $DOMAIN_NAMES; do
  if ! wp core is-installed --path=/var/www/$DOMAIN --allow-root; then
    echo "Installing wordpress..."
    # Install wordpress site
    wp core install --path=/var/www/$DOMAIN --allow-root \
    --url=$WORDPRESS_URL --title=placeholder --admin_user=lol \
    --admin_password=abahhAWCNAWFUIBAwufgaoiHFUWfiahwgf --admin_email=none@none.com
    # Set up files permissions for wordpress
    chown -R www-data:www-data /var/www/$DOMAIN
    find /var/www/$DOMAIN -type d -exec chmod 755 {} \;
    find /var/www/$DOMAIN -type f -exec chmod 644 {} \;
  fi
done

echo "Wordpress started!"
/usr/sbin/php-fpm7.4 -F