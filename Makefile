.PHONY: all clean fclean re

all: build up

build: install
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

install:
	sudo chmod a+w /etc/hosts
	sudo cat /etc/hosts | grep fsuomins.42.fr || echo "127.0.0.1 fsuomins.42.fr" >> /etc/hosts
	sudo mkdir -p /home/fsuomins/inception/data/wordpress
	sudo mkdir -p /home/fsuomins/inception/data/mariadb

clean: down
	docker system prune -af

fclean: clean
	sudo rm -rf /home/fsuomins/inception/data/mariadb
	sudo rm -rf /home/fsuomins/inception/data/wordpress
	docker volume prune -f

re: fclean all