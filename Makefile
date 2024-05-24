SHELL:= /bin/bash

DOCKER_COMPOSE = docker-compose
DC_FILE = srcs/docker-compose.yml

all: up

up:
	$(DOCKER_COMPOSE) -f $(DC_FILE) --env-file srcs/.env up --build

help:
	@echo "make up start up the cluster"
	@echo "make down shut down the cluster"
	@echo "make clean to clean the docker system"
	@echo "make fclean to delete the volume"
	@echo "make re to force rebuild images"
	@echo "make detach to make the start services in bg"

stop:
	docker stop -t 0 $(shell docker ps -q)

rebuild: set_up_hosts set_up_remap set_up_volumes
	$(DOCKER_COMPOSE) -f $(DC_FILE) --env-file srcs/.env up --build --force-recreate

detach: set_up_hosts set_up_remap set_up_volumes
	$(DOCKER_COMPOSE) -f $(DC_FILE) --env-file srcs/.env up -d --build

down:
	$(DOCKER_COMPOSE) -f $(DC_FILE) --env-file srcs/.env down

clean:
	docker system prune -af

fclean: clean
	sudo rm -rf ~/data
	docker volume rm $(shell docker volume ls -q)

re: fclean up

status:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) ps

exec_nginx:
	docker exec -it nginx-container /bin/bash

exec_wordpress:
	docker exec -it wordpress-container /bin/bash

exec_mariadb:
	docker exec -it mariadb-container /bin/bash