set -e
if [ ! -f .env ]; then
    echo "ssl_create.sh: .env file does not exist."
    exit 1
fi

sudo apt-get install -y certbot

CERTBOT_PATH=$(grep "VOLUMES_PATH=" .env | cut -d'=' -f2)/.ssl
DOMAINS=$(grep "DOMAINS=" .env | cut -d'=' -f2)
# Generate SSL credentials for nginx
for DOMAIN in $DOMAINS; do
  sudo certbot certonly $1 --standalone --config-dir $CERTBOT_PATH -d $DOMAIN
  mkdir -p services/nginx/.ssl/$DOMAIN
  cp $CERTBOT_PATH/live/$DOMAIN/fullchain.pem services/nginx/.ssl/$DOMAIN/
  cp $CERTBOT_PATH/live/$DOMAIN/privkey.pem services/nginx/.ssl/$DOMAIN/
done
