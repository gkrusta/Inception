FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y \
	&& apt-get install tini mariadb-server -y

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init.sh /var/lib/mysql/init.sh

RUN chmod +x /var/lib/mysql/init.sh

EXPOSE 3306

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["sh", "/var/lib/mysql/init.sh"]