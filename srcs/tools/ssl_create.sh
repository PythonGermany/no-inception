if find ../ -type d -name ".ssl" -print -quit | grep -q .; then
    echo "ssl_create.sh: SSL directories already exist."
    exit 1
fi
read -p 'ssl_create.sh: Do you want to use certbot? (y/n): ' USE_CERTBOT

openssl genpkey -algorithm RSA -out ca-key.pem
openssl req -new -x509 -key ca-key.pem -out cacert.pem -subj $(cat ../conf/ssl_information.txt | tr -d "\n")

# Create required directories
mkdir -p ../requirements/nginx/.ssl
mkdir -p ../requirements/bonus/ftp/.ssl

# Generate SSL credentials for nginx
if [ "$USE_CERTBOT" = "y" ]; then
    read -p 'Enter your domain name: ' DOMAIN_NAME
    sudo apt-get install -y certbot
    sudo certbot certonly --standalone -d $DOMAIN_NAME 
    # Move nginx SSL credentials to the appropriate locations
    sudo cp /etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem ../requirements/nginx/.ssl/server-cert.pem
    sudo cp /etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem ../requirements/nginx/.ssl/server-key.pem
else
    sh ssl_generate.sh server
    # Move nginx SSL credentials to the appropriate locations
    cp cacert.pem ../requirements/nginx/.ssl/
    mv server-cert.pem ../requirements/nginx/.ssl/
    mv server-key.pem ../requirements/nginx/.ssl/
fi

# Generate SSL credentials for ftp server
sh ssl_generate.sh server

# Move ftp SSL credentials to the appropriate locations
mv cacert.pem ../requirements/bonus/ftp/.ssl/
mv server-cert.pem ../requirements/bonus/ftp/.ssl/
mv server-key.pem ../requirements/bonus/ftp/.ssl/

rm -f ca-key.pem