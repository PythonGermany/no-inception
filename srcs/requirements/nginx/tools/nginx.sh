# Install requirements for nginx
apt-get install -y nginx && \

# Create required directories
mkdir -p /etc/ssl/certs && \
mkdir -p /etc/ssl/private && \

# Move SSL credentials to the appropriate locations
mv server-cert.pem /etc/ssl/certs/ssl-cert-snakeoil.pem && \
mv server-key.pem /etc/ssl/private/ssl-cert-snakeoil.key && \

# Set up nginx config
sed -i "s/{DOMAIN_NAME}/$DOMAIN_NAME/g" wordpress.conf && \
sed -i "s/{WORDPRESS_HOST}/$WORDPRESS_HOST/g" wordpress.conf && \
sed -i "s/{WORDPRESS_PORT}/$WORDPRESS_PORT/g" wordpress.conf && \

# Move config files to their respective locations
mv wordpress.conf /etc/nginx/sites-available/$DOMAIN_NAME.conf && \

# Enable nginx site
ln -s /etc/nginx/sites-available/$DOMAIN_NAME.conf /etc/nginx/sites-enabled/ && \

# Remove default nginx site
rm -rf /etc/nginx/sites-enabled/default
