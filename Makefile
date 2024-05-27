SHELL:= /bin/bash

DOCKER_COMPOSE = docker-compose
DC_FILE = srcs/docker-compose.yml

all: up

up:
	$(DOCKER_COMPOSE) -f $(DC_FILE) up -d --build

help:
	@echo "make up start up the cluster"
	@echo "make down shut down the cluster"
	@echo "make clean to clean the docker system"
	@echo "make fclean to delete the volume"

stop:
	docker stop -t 0 $(shell docker ps -q)

down:
	$(DOCKER_COMPOSE) -f $(DC_FILE) down

clean:
	docker system prune -af

fclean: clean
	docker volume rm $(shell docker volume ls -q)

re: fclean up

exec_nginx:
	docker exec -it nginx-container /bin/bash

exec_wordpress:
	docker exec -it wordpress-container /bin/bash

exec_mariadb:
	docker exec -it mariadb-container /bin/bash