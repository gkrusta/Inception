FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y \
	&& apt-get install php-fpm php-mysql wget unzip tini -y \
	&& wget http://wordpress.org/latest.tar.gz \
	&& mkdir -p /var/www/html \
	&& tar xfz latest.tar.gz -C /var/www/html \
	&& mv /var/www/html/wordpress/* /var/www/html \
	&& rm -rf latest.tar.gz && rm -fr /var/www/html/wordpress \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./tools/wp.sh /tmp/wp.sh

EXPOSE 9000

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["sh", "/tmp/wp.sh"]