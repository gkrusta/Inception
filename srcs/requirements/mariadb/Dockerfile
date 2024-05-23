FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y \
	&& apt-get install tini mariadb-server -y \
	&& apt-get update && apt-get install -y iputils-ping

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init.sh /docker-entrypoint-initdb.d/init.sh

RUN chmod +x /docker-entrypoint-initdb.d/init.sh

EXPOSE 3306

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["sh", "/docker-entrypoint-initdb.d/init.sh"]