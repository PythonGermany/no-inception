FROM debian:oldstable

# Domain name argments
ARG DOMAINS_ARG
# Wordpress argments
ARG WORDPRESS_HOST_ARG
ARG WORDPRESS_PORT_ARG

# Domain name env
ENV DOMAINS=$DOMAINS_ARG
# Wordpress env
ENV WORDPRESS_HOST=$WORDPRESS_HOST_ARG
ENV WORDPRESS_PORT=$WORDPRESS_PORT_ARG

COPY conf/. .
COPY tools/. .
COPY .ssl .

RUN apt-get update && apt-get upgrade -y && sh nginx.sh

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]