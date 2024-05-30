FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install vim tini nginx openssl -y

COPY ./tools/nginx.sh /tmp/nginx.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT ["/usr/bin/tini", "--"]

RUN chmod +x /tmp/nginx.sh

CMD ["sh", "/tmp/nginx.sh"]