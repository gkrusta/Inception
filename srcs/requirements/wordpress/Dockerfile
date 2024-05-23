FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y \
	&& apt-get install php-fpm php-mysql wget unzip -y \
	&& apt-get install tini -y \
	&& wget http://wordpress.org/latest.tar.gz \
	&& mkdir -p /var/www/html \
	&& tar xfz latest.tar.gz -C /var/www/html \
	&& rm -rf latest.tar.gz

RUN apt-get update && apt-get install -y iputils-ping

COPY ./tools/wp.sh /tmp/wp.sh

EXPOSE 9000

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["sh", "/tmp/wp.sh"]