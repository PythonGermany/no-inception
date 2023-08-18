ARG =

# Colors
BLACK = \033[0;30m
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
MAGENTA = \033[0;35m
CYAN = \033[0;36m
WHITE = \033[0;37m
RESET = \033[0m

all: up

# Docker
up: base_build
	sudo docker compose -f srcs/docker-compose.yml up -d
down:
	sudo docker compose -f srcs/docker-compose.yml down
update:
	sudo docker compose -f srcs/docker-compose.yml build --no-cache --force-rm $(ARG)

# Setup
setup: env_create credentials_create ssl_create volumes_create
docker_install:
	@sudo sh srcs/tools/docker_install.sh $(ARG)
base_build:
	docker build -t base srcs/base
env_create:
	@(cd srcs && sh tools/env_create.sh)
credentials_create:
	@(cd srcs && sh tools/credentials_create.sh)
ssl_create:
	@(cd srcs && sh tools/ssl_create.sh $(ARG))
volumes_create:
	@(cd srcs && sh tools/volumes_create.sh)

# Delete
env_delete:
	@(cd srcs && sh tools/env_delete.sh)
credentials_delete:
	@(cd srcs && sh tools/credentials_delete.sh)
ssl_delete:
	@(cd srcs && sh tools/ssl_delete.sh)
volumes_delete:
	@(cd srcs && sh tools/volumes_delete.sh)

# Utils
files_to_unix:
	sudo apt-get install dos2unix
	find . -type f -exec dos2unix {} +

# Clean and rebuild
clean: down
	sudo docker image prune -a -f
fclean: clean volumes_delete ssl_delete credentials_delete env_delete
	sudo docker system prune -f --volumes
re: fclean setup up
