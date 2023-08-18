# Install requirements for redis
apt-get install -y redis-server && \

# Set up redis config
REDIS_PW=$(cat redis/redis.secret | grep "REDIS_PW" | cut -d'=' -f2) && \
sed -i "s/{REDIS_PW}/$REDIS_PW/g" redis.conf && \
sed -i "s/{REDIS_HOST}/$REDIS_HOST/g" redis.conf && \
sed -i "s/{REDIS_PORT}/$REDIS_PORT/g" redis.conf && \

# Move config files to their respective locations
mv redis.conf /etc/redis/

rm -rf redis