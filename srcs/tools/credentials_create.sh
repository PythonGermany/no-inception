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
  else
    echo "credentials_create.sh: $DOMAIN: Mysql credentials already exists. Skipping credential creation"
  fi
  

  if [ ! -f conf/wordpress/$DOMAIN.secret ]
    read -p "credentials_create.sh: $DOMAIN: Enter the admin user name: " ADMIN
    read -p "credentials_create.sh: $DOMAIN: Enter the admin email: " ADMIN_EMAIL
    echo "WP_TITLE=placeholder" > conf/wordpress/$DOMAIN.secret
    echo "WP_ADMIN=$ADMIN" >> conf/wordpress/$DOMAIN.secret
    echo "WP_ADMIN_PW=$(openssl rand -base64 64 | tr -d '=\n\/')" >> conf/wordpress/$DOMAIN.secret
    echo "WP_ADMIN_EMAIL=$ADMIN_EMAIL" >> conf/wordpress/$DOMAIN.secret
  else
    echo "credentials_create.sh: $DOMAIN: Wordpress credentials already exists. Skipping credential creation"
  fi
done
ln -s conf/mysql services/mariadb/conf/
ln -s conf/mysql services/wordpress/conf/
ln -s conf/wordpress services/wordpress/conf/