.PHONY: all clean fclean re

all: build up

build: 
	mkdir -p /home/fer/inception/data/wordpress
	mkdir -p /home/fer/inception/data/mariadb
	docker compose -f srcs/docker-compose.yml build

up:
	docker compose -f srcs/docker-compose.yml up -d

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af

fclean: clean
	rm -rf data/mariadb/* data/wordpress/*
	docker volume prune -f

re: fclean all