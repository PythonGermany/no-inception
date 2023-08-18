set -e
read -p "credentials_delete.sh: WARNING DANGER ZONE: Delete your credentials? (yes/n): " RESPONSE
if [ "$RESPONSE" = "yes" ]; then
  rm -rf conf/mysql
  rm -rf conf/wordpress
  rm -rf conf/redis
  rm -rf services/mariadb/conf/mysql
  rm -rf services/wordpress/conf/mysql
  rm -rf services/wordpress/conf/wordpress
  rm -rf services/redis/conf/redis
  rm -rf services/wordpress/conf/redis
else
  echo "credentials_delete.sh: Abort!"
fi