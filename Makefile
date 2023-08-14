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
up:
	sudo docker compose -f srcs/docker-compose.yml up -d
down:
	sudo docker compose -f srcs/docker-compose.yml down
update:
	sudo docker compose -f srcs/docker-compose.yml build --no-cache --force-rm $(ARG)

# Setup
setup: base_build env_create wp_defaults_create ssl_create volumes_create
docker_install:
	@sudo sh srcs/tools/docker_install.sh $(ARG)
base_build:
	docker build -t base srcs/base
env_create:
	@(cd srcs && sh tools/env_create.sh)
wp_defaults_create:
	@(cd srcs && sh tools/wp_defaults_create.sh)
ssl_create:
	@(cd srcs && sh tools/ssl_create.sh $(ARG))
volumes_create:
	@(cd srcs && sh tools/volumes_create.sh)

# Delete
env_delete:
	@(cd srcs && sh tools/env_delete.sh)
wp_defaults_delete:
	@(cd srcs && sh tools/wp_defaults_delete.sh)
ssl_delete:
	@(cd srcs && sh tools/ssl_delete.sh)
volumes_delete:
	@(cd srcs && sh tools/volumes_delete.sh)

# Utils
files_to_unix:
	sudo apt-get install dos2unix
	find . -type f -exec dos2unix {} +
help:
	@echo "$(RED)Usage: $(YELLOW)make [target] [ARG=\"...\"]"
	@echo "Targets:$(RESET)"
	@echo "  all (default)  - Run 'make up'"
	@echo "$(RED)--------------------- Docker ---------------------$(RESET)"
	@echo "  up             - Start containers and run '$(CYAN)make volumes_delete$(RESET)'"
	@echo "  down           - Stop containers"
	@echo "  update         - Rebuild container"
	@echo "$(RED)--------------------- Setup ---------------------"
	@echo "$(YELLOW)  setup          - Run 'make $(GREEN)env_create $(BLUE)ssl_create $(MAGENTA)'"
	@echo "$(WHITE)  docker_install - Install docker"
	@echo "$(GREEN)  env_create     - Create .env file using random passwords"
	@echo "$(BLUE)  ssl_create     - Create SSL certificates"
	@echo "$(CYAN)  volumes_create  - Create volume directories"
	@echo "$(RED)--------------------- Delete ---------------------"
	@echo "$(GREEN)  env_delete     - Delete .env file"
	@echo "$(BLUE)  ssl_delete     - Delete SSL certificates"
	@echo "$(CYAN)  volumes_delete  - Delete volume directories"
	@echo "$(RED)--------------------- Utils ---------------------$(RESET)"
	@echo "  files_to_unix  - Convert files to unix format"
	@echo "  help           - Display this help message"
	@echo "$(RED)--------------------- Clean ---------------------$(RESET)"
	@echo "  clean          - run 'make down' and delete unused images"
	@echo "$(RED)  fclean         - Run 'make $(WHITE)clean $(GREEN)env_delete $(BLUE)ssl_delete"
	@echo "                        $(CYAN)volumes_delete$(RESET)' and delete unused images"
	@echo "$(RED)  re             - Run 'make fclean setup up'$(RESET)"

# Clean and rebuild
clean: down
	sudo docker image prune -a -f
fclean: clean ssl_delete volumes_delete wp_defaults_delete env_delete
	sudo docker system prune -f --volumes
re: fclean setup up
