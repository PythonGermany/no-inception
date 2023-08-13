FROM debian:oldstable

ARG DOMAIN_NAMES_ARG
ARG MYSQL_ROOT_PW_ARG

ENV DOMAIN_NAMES=$DOMAIN_NAMES_ARG
ENV MYSQL_ROOT_PW=$MYSQL_ROOT_PW_ARG

COPY conf/. .
COPY tools/. .

RUN apt-get update && apt-get upgrade -y && sh mariadb.sh

CMD [ "/usr/sbin/mariadbd"]