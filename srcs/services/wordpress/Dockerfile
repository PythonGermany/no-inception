FROM debian:oldstable

# Domain arguments
ARG DOMAINS_ARG
# Wordpress arguments
ARG WORDPRESS_HOST_ARG
ARG WORDPRESS_PORT_ARG
# Database arguments
ARG MYSQL_HOST_ARG
ARG MYSQL_PORT_ARG

# Domain environment variables
ENV DOMAINS=$DOMAINS_ARG
# Wordpress environment variables
ENV WORDPRESS_HOST=$WORDPRESS_HOST_ARG
ENV WORDPRESS_PORT=$WORDPRESS_PORT_ARG
# Database environment variables
ENV MYSQL_HOST=$MYSQL_HOST_ARG
ENV MYSQL_PORT=$MYSQL_PORT_ARG

COPY conf/. .
COPY tools/. .

RUN apt-get update && apt-get upgrade -y && sh wordpress.sh

CMD ["sh", "start.sh"]