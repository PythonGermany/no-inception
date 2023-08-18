FROM base

ARG DOMAIN_ARG
ARG MYSQL_ROOT_PW_ARG

ENV DOMAIN=$DOMAIN_ARG
ENV MYSQL_ROOT_PW=$MYSQL_ROOT_PW_ARG

COPY conf/. .
COPY tools/. .

RUN sh mariadb.sh

CMD [ "/usr/sbin/mariadbd"]
