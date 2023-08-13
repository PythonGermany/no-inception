set -e
# Install requirements for nginx
apt-get install -y nginx && \

mkdir -p /etc/letsencrypt/live/ && \

# Move SSL credentials to the appropriate location
for DOMAIN in $DOMAINS; do
  mkdir -p /etc/letsencrypt/live/$DOMAIN
  mv .ssl/$DOMAIN/. /etc/letsencrypt/live/$DOMAIN
done

# Remove default nginx site
rm -rf /etc/nginx/sites-enabled/default

for DOMAIN in $DOMAINS; do
  # Copy nginx config template
  cp server.conf $DOMAIN.conf
  # Set up nginx config
  sed -i "s/{DOMAIN}/$DOMAIN/g" $DOMAIN.conf
  sed -i "s/{WORDPRESS_HOST}/$WORDPRESS_HOST/g" $DOMAIN.conf
  sed -i "s/{WORDPRESS_PORT}/$WORDPRESS_PORT/g" $DOMAIN.conf
  # Move config file to their respective location
  mv $DOMAIN.conf /etc/nginx/sites-available/
  # Enable nginx site
  ln -s /etc/nginx/sites-available/$DOMAIN.conf /etc/nginx/sites-enabled/
done