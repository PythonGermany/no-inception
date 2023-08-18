set -e
# Install requirements for nginx
apt-get install -y nginx && \

# Remove default nginx site
rm -rf /etc/nginx/sites-enabled/default
rm -rf /var/www/html

# Copy nginx config template
mv server.conf $DOMAIN.conf
# Set up nginx config
sed -i "s/{DOMAIN}/$DOMAIN/g" $DOMAIN.conf
sed -i "s/{WORDPRESS_HOST}/$WORDPRESS_HOST/g" $DOMAIN.conf
sed -i "s/{WORDPRESS_PORT}/$WORDPRESS_PORT/g" $DOMAIN.conf
# Move config file to their respective location
mv $DOMAIN.conf /etc/nginx/sites-available/
# Enable nginx site
ln -s /etc/nginx/sites-available/$DOMAIN.conf /etc/nginx/sites-enabled/