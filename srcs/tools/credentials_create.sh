set -e
if [ ! -f .env ]; then
    echo "credentials_create.sh: .env file does not exist."
    exit 1
fi

mkdir -p conf/mysql
mkdir -p conf/wordpress
mkdir -p conf/redis
DOMAIN=$(grep "DOMAIN=" .env | cut -d'=' -f2)
if [ ! -f conf/mysql/mysql.secret ]; then
  echo "DB_NAME=wp_$DOMAIN" > conf/mysql/mysql.secret
  echo "DB_USER=user_$DOMAIN" >> conf/mysql/mysql.secret
  echo "DB_PASSWORD=$(openssl rand -base64 64 | tr -d '=\n\/')" >> conf/mysql/mysql.secret
else
  echo "credentials_create.sh: $DOMAIN: Mysql credentials already exists. Skipping credential creation"
fi

if [ ! -f conf/wordpress/$DOMAIN.secret ]; then
  read -p "credentials_create.sh: $DOMAIN: Enter the admin user name: " ADMIN
  read -p "credentials_create.sh: $DOMAIN: Enter the admin email: " ADMIN_EMAIL
  echo "WP_TITLE=placeholder" > conf/wordpress/$DOMAIN.secret
  echo "WP_ADMIN=$ADMIN" >> conf/wordpress/$DOMAIN.secret
  echo "WP_ADMIN_PW=$(openssl rand -base64 64 | tr -d '=\n\/')" >> conf/wordpress/$DOMAIN.secret
  echo "WP_ADMIN_EMAIL=$ADMIN_EMAIL" >> conf/wordpress/$DOMAIN.secret
else
  echo "credentials_create.sh: $DOMAIN: Wordpress credentials already exists. Skipping credential creation"
fi

if [ ! -f conf/redis/redis.secret ]; then
  echo "REDIS_PW=$(openssl rand -base64 64 | tr -d '=\n\/')" > conf/redis/redis.secret
else
  echo "credentials_create.sh: $DOMAIN: Redis credentials already exists. Skipping credential creation"
fi

cp -r conf/mysql services/mariadb/conf/
cp -r conf/mysql services/wordpress/conf/
cp -r conf/wordpress services/wordpress/conf/
cp -r conf/redis services/redis/conf/
cp -r conf/redis services/wordpress/conf/