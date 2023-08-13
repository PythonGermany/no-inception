set -e
if [ ! -f .env ]; then
    echo "ssl_create.sh: .env file does not exist."
    exit 1
fi

DOMAINS=$(grep "DOMAINS=" .env | cut -d'=' -f2)
for DOMAIN in $DOMAINS; do
  if [ ! -f services/wordpress/conf/wordpress/$DOMAIN.keys ]; then
    # Read user input
    read -p "wordpress_setup.sh: $DOMAIN: Enter the site title: " TITLE
    read -p "wordpress_setup.sh: $DOMAIN: Enter the admin user name: " ADMIN
    read -p "wordpress_setup.sh: $DOMAIN: Enter the admin email: " ADMIN_EMAIL
    cp conf/wordpress-user-sample.keys conf/$DOMAIN.keys
    sed -i "s/{WP_TITLE}/$TITLE/g" conf/$DOMAIN.keys
    sed -i "s/{WP_ADMIN}/$ADMIN/g" conf/$DOMAIN.keys
    sed -i "s/{WP_ADMIN_PW}/$(openssl rand -base64 64 | tr -d '=\n\/')/g" conf/$DOMAIN.keys
    sed -i "s/{WP_ADMIN_EMAIL}/$ADMIN_EMAIL/g" conf/$DOMAIN.keys
    mv conf/$DOMAIN.keys services/wordpress/conf/wordpress/
  fi
done
