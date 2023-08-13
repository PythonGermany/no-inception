set -e
# Read user input
read -p 'env_create.sh: Enter the desired volume path: ' VOLUMES_PATH

# Create the volume directories
mkdir -p $VOLUMES_PATH/.credentials
mkdir -p $VOLUMES_PATH/wordpress
mkdir -p $VOLUMES_PATH/mariadb