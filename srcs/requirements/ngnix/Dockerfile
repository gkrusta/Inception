FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install tini -y \
    && apt-get install ngnix -y \
    && apt-get install openssl -y \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=MO/L=KH/O=1337/OU=student/CN=[sahafid.1337.ma](http://sahafid.42.ma/)"

COPY ./tools/ngnix.sh /tmp/ngnix.sh

EXPOSE 9000

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["sh", "/tmp/ngnix.sh"]