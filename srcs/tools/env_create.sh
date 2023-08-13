set -e
if [ -f .env ]; then
    echo "env_create.sh: .env file already exists."
    exit 1
fi

# Copy template .env file
cp conf/.env-sample .env

# Read user input
read -p 'env_create.sh: Enter the desired volume path: ' VOLUMES_PATH
read -p 'env_create.sh: Enter your domain name(s) separated by spaces: ' DOMAINS

# Insert default values and user input into .env file
sed -i "s|{VOLUMES_PATH}|$VOLUMES_PATH|g" .env
sed -i "s/{DOMAINS}/$DOMAINS/g" .env
sed -i "s/{MYSQL_ROOT_PW}/$(openssl rand -base64 64 | tr -d '=\n\/')/g" .env