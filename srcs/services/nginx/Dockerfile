FROM base

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
COPY .ssl/. /etc/letsencrypt/live/

RUN sh nginx.sh

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
