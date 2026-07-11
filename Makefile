DATA_PATH = $(shell grep ^DATA_PATH srcs/.env | cut -d '=' -f2)

all: up

up: setup
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -a --volumes -f

fclean: clean
	@if [ -d "$(DATA_PATH)" ]; then \
		echo "Removing persistent data at $(DATA_PATH)..."; \
		sudo rm -rf $(DATA_PATH)/wordpress; \
		sudo rm -rf $(DATA_PATH)/mariadb; \
	fi
	rm -rf secrets

re: fclean all

setup:
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p secrets
	@if [ ! -f secrets/db_password.txt ]; then \
		echo "wp_db_pass_123" > secrets/db_password.txt; \
	fi
	@if [ ! -f secrets/db_root_password.txt ]; then \
		echo "mariadb_root_pass_123" > secrets/db_root_password.txt; \
	fi
	@if [ ! -f secrets/credentials.txt ]; then \
		echo "wp_admin_pass_123" > secrets/credentials.txt; \
	fi

.PHONY: all up down clean fclean re setup
