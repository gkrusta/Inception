FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y \
	&& apt-get install tini mariadb-server -y

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
	

RUN chmod +x install.sh

EXPOSE 3306

ENTRYPOINT ["/usr/bin/tini", "--"]


CMD ["bash", "install.sh"]