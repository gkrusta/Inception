FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y \
	&& apt-get install php-fpm php-mysql wget -y \
	&& apt-get install tini -y \
	&& wget https://wordpress.org/latest.zip \
	&& unzip latest.zip -d /var/www/html/ \
	&& rm latest.zip \
	&& 


COPY ./tools/wp.sh /tmp/wp.sh

EXPOSE 9000

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["sh", ""]