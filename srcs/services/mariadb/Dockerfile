FROM base

ARG MYSQL_ROOT_PW_ARG

ENV MYSQL_ROOT_PW=$MYSQL_ROOT_PW_ARG

COPY conf/. .
COPY tools/. .

RUN sh mariadb.sh

CMD [ "/usr/sbin/mariadbd"]
