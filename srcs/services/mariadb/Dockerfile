FROM debian:oldstable

ARG DOMAINS_ARG
ARG MYSQL_ROOT_PW_ARG

ENV DOMAINS=$DOMAINS_ARG
ENV MYSQL_ROOT_PW=$MYSQL_ROOT_PW_ARG

COPY conf/. .
COPY tools/. .

RUN apt-get update && apt-get upgrade -y && sh mariadb.sh

CMD [ "/usr/sbin/mariadbd"]