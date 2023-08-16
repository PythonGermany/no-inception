set -e
if [ ! -f .env ]; then
  cp conf/.env-sample .env
  read -p 'env_create.sh: Enter the desired volume path: ' VOLUMES_PATH
  read -p 'env_create.sh: Enter your domain name(s) separated by spaces: ' DOMAINS
  sed -i "s|{VOLUMES_PATH}|$VOLUMES_PATH|g" .env
  sed -i "s/{DOMAINS}/$DOMAINS/g" .env
  sed -i "s/{MYSQL_ROOT_PW}/$(openssl rand -base64 64 | tr -d '=\n\/')/g" .env
else
  echo "env_create.sh: Env file already exists. Skipping env creation"
fi