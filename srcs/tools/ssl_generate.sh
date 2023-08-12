# Create set of SSL credentials
openssl genpkey -algorithm RSA -out $1-key.pem
openssl req -new -key $1-key.pem -out $1-req.pem -subj $(cat ../conf/ssl_information.txt | tr -d "\n")
openssl x509 -req -in $1-req.pem -CA cacert.pem -CAkey ca-key.pem -CAcreateserial -out $1-cert.pem
rm $1-req.pem