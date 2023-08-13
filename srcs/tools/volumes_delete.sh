set -e
if [ ! -f .env ]; then
    echo "volumes_delete.sh: .env file does not exist."
    exit 1
fi
VOLUMES_PATH=$(grep "VOLUMES_PATH=" .env | cut -d'=' -f2)
read -p "volume_delete.sh: WARNING DANGER ZONE: Deleting your data volumes? (yes/n): " RESPONSE
if [ "$RESPONSE" = "yes" ]; then
  rm -rf $VOLUMES_PATH/.credentials
  rm -rf $VOLUMES_PATH/wordpress
	rm -rf $VOLUMES_PATH/mariadb
  if [ -z "$(ls -A $VOLUMES_PATH)" ]; then
    rm -rf $VOLUMES_PATH
  fi
else
  echo "volume_delete.sh: Abort"
fi
