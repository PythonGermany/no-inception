set -e
if [ ! -f .env ]; then
    echo "credentials_create.sh: .env file does not exist."
    exit 1
fi

mkdir -p conf/mysql
mkdir -p conf/wordpress
DOMAINS=$(grep "DOMAINS=" .env | cut -d'=' -f2)
for DOMAIN in $DOMAINS; do
  if [ ! -f conf/mysql/$DOMAIN.secret ]
    echo "DB_NAME=wp_$DOMAIN" > conf/mysql/$DOMAIN.secret
    echo "DB_USER=user_$DOMAIN" >> conf/mysql/$DOMAIN.secret
    echo "DB_PASSWORD=$(openssl rand -base64 64 | tr -d '=\n\/')" >> conf/mysql/$DOMAIN.secret
  fi

  if [ ! -f conf/wordpress/$DOMAIN.secret ]
    read -p "credentials_create.sh: $DOMAIN: Enter the site title: " TITLE
    read -p "credentials_create.sh: $DOMAIN: Enter the admin user name: " ADMIN
    read -p "credentials_create.sh: $DOMAIN: Enter the admin email: " ADMIN_EMAIL
    echo "WP_TITLE=$TITLE" > conf/wordpress/$DOMAIN.secret
    echo "WP_ADMIN=$ADMIN" >> conf/wordpress/$DOMAIN.secret
    echo "WP_ADMIN_PW=$(openssl rand -base64 64 | tr -d '=\n\/')" >> conf/wordpress/$DOMAIN.secret
    echo "WP_ADMIN_EMAIL=$ADMIN_EMAIL" >> conf/wordpress/$DOMAIN.secret
  fi
done
cp -r conf/mysql services/mariadb/conf/
cp -r conf/mysql services/wordpress/conf/
cp -r conf/wordpress services/wordpress/conf/