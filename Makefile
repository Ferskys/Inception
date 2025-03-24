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

hard_clean: 
	docker stop $(docker ps -qa)
	docker rm $(docker ps -qa)
	docker rmi -f $(docker images -qa)
	docker volume rm $(docker volume ls -q)
	docker network rm $(docker network ls -q) 2>/dev/null

.PHONY: all clean fclean re