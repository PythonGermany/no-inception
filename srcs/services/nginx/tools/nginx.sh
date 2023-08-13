set -e
# Install requirements for nginx
apt-get install -y nginx && \

mkdir -p /etc/letsencrypt/live/ && \

# Move SSL credentials to the appropriate location
mv .ssl/. /etc/letsencrypt/live/ && \

# Remove default nginx site
rm -rf /etc/nginx/sites-enabled/default

for DOMAIN_NAME in $DOMAIN_NAMES; do
  # Copy nginx config template
  cp wordpress.conf $DOMAIN_NAME.conf
  # Set up nginx config
  sed -i "s/{DOMAIN_NAME}/$DOMAIN_NAME/g" $DOMAIN_NAME.conf
  sed -i "s/{WORDPRESS_HOST}/$WORDPRESS_HOST/g" $DOMAIN_NAME.conf
  sed -i "s/{WORDPRESS_PORT}/$WORDPRESS_PORT/g" $DOMAIN_NAME.conf
  # Move config file to their respective location
  mv $DOMAIN_NAME.conf /etc/nginx/sites-available/
  # Enable nginx site
  ln -s /etc/nginx/sites-available/$DOMAIN_NAME.conf /etc/nginx/sites-enabled/
done