set -e
if ! wp core is-installed --path=/var/www/$DOMAIN --allow-root; then
  echo "Installing and setting up wordpress for $DOMAIN..."
  # Install wordpress site
  WP_TITLE=$(grep "WP_TITLE=" /wordpress/$DOMAIN.secret | cut -d'=' -f2)
  WP_ADMIN=$(grep "WP_ADMIN=" /wordpress/$DOMAIN.secret | cut -d'=' -f2)
  WP_ADMIN_PW=$(grep "WP_ADMIN_PW=" /wordpress/$DOMAIN.secret | cut -d'=' -f2)
  WP_ADMIN_EMAIL=$(grep "WP_ADMIN_EMAIL=" /wordpress/$DOMAIN.secret | cut -d'=' -f2)
  wp core install --path=/var/www/$DOMAIN --allow-root \
    --url="https://$DOMAIN" --title=$WP_TITLE --admin_user=$WP_ADMIN \
    --admin_password=$WP_ADMIN_PW --admin_email=$WP_ADMIN_EMAIL
  wp plugin install redis-cache --activate --path=/var/www/$DOMAIN_NAME --allow-root
  wp redis enable --path=/var/www/$DOMAIN_NAME --allow-root
  #  Set up files permissions for wordpress
  chown -R www-data:www-data /var/www/$DOMAIN
  find /var/www/$DOMAIN -type d -exec chmod 755 {} \;
  find /var/www/$DOMAIN -type f -exec chmod 644 {} \;
  rm -rf /wordpress
fi

echo "Wordpress started!"
/usr/sbin/php-fpm7.4 -F
