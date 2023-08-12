FROM debian:oldstable

ARG REDIS_PW_ARG
ARG REDIS_HOST_ARG
ARG REDIS_PORT_ARG

ENV REDIS_PW=$REDIS_PW_ARG
ENV REDIS_HOST=$REDIS_HOST_ARG
ENV REDIS_PORT=$REDIS_PORT_ARG

COPY conf/. .
COPY tools/. .

RUN apt-get update && apt-get upgrade -y && sh redis.sh

CMD [ "redis-server", "/etc/redis/redis.conf"]