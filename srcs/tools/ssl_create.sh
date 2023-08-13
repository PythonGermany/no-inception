set -e
if find . -type d -name ".ssl" -print -quit | grep -q .; then
    echo "ssl_create.sh: SSL directories already exist."
    exit 1
fi

sudo apt-get install -y certbot

# Read user input
read -p 'ssl_create.sh: Enter the location your certbot credentials will be stored: ' CERTBOT_PATH
read -p 'ssl_create.sh: Enter your domain name(s) separated by spaces: ' DOMAIN_NAMES

# Generate SSL credentials for nginx
for DOMAIN_NAME in $DOMAIN_NAMES; do
  sudo certbot certonly $1 --standalone --config-dir $CERTBOT_PATH -d $DOMAIN_NAME
  mkdir -p services/nginx/.ssl/$DOMAIN_NAME
  cp $CERTBOT_PATH/live/$DOMAIN_NAME/fullchain.pem services/nginx/.ssl/$DOMAIN_NAME/server-cert.pem
  cp $CERTBOT_PATH/live/$DOMAIN_NAME/privkey.pem services/nginx/.ssl/$DOMAIN_NAME/server-key.pem
done