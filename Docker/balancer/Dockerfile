FROM haproxy:1.7-alpine

ADD entrypoint.sh /

RUN sed -i 's/set -e/sh \/entrypoint.sh; set -e/' /docker-entrypoint.sh