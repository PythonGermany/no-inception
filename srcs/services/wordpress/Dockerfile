FROM base

# Domain arguments
ARG DOMAIN_ARG
# Wordpress arguments
ARG WORDPRESS_HOST_ARG
ARG WORDPRESS_PORT_ARG
# Database arguments
ARG MYSQL_HOST_ARG
ARG MYSQL_PORT_ARG
# Redis arguments
ARG REDIS_HOST_ARG
ARG REDIS_PORT_ARG

# Domain environment variables
ENV DOMAIN=$DOMAIN_ARG
# Wordpress environment variables
ENV WORDPRESS_HOST=$WORDPRESS_HOST_ARG
ENV WORDPRESS_PORT=$WORDPRESS_PORT_ARG
# Database environment variables
ENV MYSQL_HOST=$MYSQL_HOST_ARG
ENV MYSQL_PORT=$MYSQL_PORT_ARG
# Redis environment variables
ENV REDIS_HOST=$REDIS_HOST_ARG
ENV REDIS_PORT=$REDIS_PORT_ARG

COPY conf/. .
COPY tools/. .

RUN sh wordpress.sh

CMD ["sh", "start.sh"]
