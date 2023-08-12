if ! wp core is-installed --path=/var/www/$DOMAIN_NAME --allow-root; then
  echo "Installing wordpress..."
  # Install wordpress site
  wp core install --path=/var/www/$DOMAIN_NAME --allow-root \
  --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN \
  --admin_password=$WORDPRESS_ADMIN_PW --admin_email=$WORDPRESS_ADMIN_EMAIL && \
  # Install and enable redis-cache plugin
  wp plugin install https://downloads.wordpress.org/plugin/redis-cache.2.4.3.zip \
    --activate --path=/var/www/$DOMAIN_NAME --allow-root
  wp redis enable --path=/var/www/$DOMAIN_NAME --allow-root
  # Install additional util plugins
  if [ "$WORDPRESS_PLUGINS" != "" ]; then
    utils=$(echo $WORDPRESS_PLUGINS | tr "," "\n")
    for util in $utils; do
      wp plugin install $util --activate --path=/var/www/$DOMAIN_NAME --allow-root
    done
  fi
  # Set up files permissions for wordpress
  chown -R www-data:www-data /var/www/$DOMAIN_NAME
  find /var/www/$DOMAIN_NAME -type d -exec chmod 775 {} \;
  find /var/www/$DOMAIN_NAME -type f -exec chmod 664 {} \;
fi

echo "Wordpress started!"
/usr/sbin/php-fpm7.4 -F