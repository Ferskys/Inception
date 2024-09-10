all: up

up:
	@docker compose -f srcs/docker-compose.yml up --build -d

down:
	@docker compose -f srcs/docker-compose.yml down

clean:
	@docker system prune -af
	@docker volume prune -f

hardclean: clean
	@sudo rm -rf srcs/db srcs/web

fclean: down clean

re: fclean all

.PHONY: all up down clean hardclean fclean re