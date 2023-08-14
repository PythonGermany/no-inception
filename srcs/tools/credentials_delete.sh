set -e
read -p "credentials_delete.sh: WARNING DANGER ZONE: Delete your credentials? (yes/n): " RESPONSE
if [ "$RESPONSE" = "yes" ]; then
  rm -rf conf/mysql
  rm -rf conf/wordpress
  rm -rf services/mariadb/conf/mysql
  rm -rf services/wordpress/conf/mysql
  rm -rf services/wordpress/conf/wordpress
else
  echo "credentials_delete.sh: Abort!"
fi
