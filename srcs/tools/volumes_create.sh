set -e
if [ ! -f .env ]; then
    echo "volumes_create.sh: .env file does not exist."
    exit 1
fi
VOLUMES_PATH=$(grep "VOLUMES_PATH=" .env | cut -d'=' -f2)
mkdir -p $VOLUMES_PATH/wordpress
mkdir -p $VOLUMES_PATH/mariadb