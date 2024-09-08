.PHONY: build run test exec sh clean help all

NAME = php
IMAGE = simonrupf/$(NAME)
PORT = 8080
CMD = /bin/ash

build: ## Build the container image (default).
	docker build -t $(IMAGE) --load .

run: ## Run a container from the image.
	docker run -d --init --name $(NAME) -p=$(PORT):$(PORT) --read-only --restart=always $(IMAGE)

test: ## Launch tests to verify that the service works as expected, requires a running container.
	@sleep 1
	nc -z localhost $(PORT)
	curl -sI http://localhost:$(PORT)/ | grep -qm1 " 404 Not Found"

exec: ## Execute a shell in the running container for inspection, requires a running container.
	docker exec -ti $(NAME) $(CMD)

sh: ## Run a shell instead of the service for inspection, deletes the container when you leave it.
	docker run -ti --rm --init --name $(NAME) -p=$(PORT):$(PORT) --read-only --entrypoint=$(CMD) $(IMAGE)

clean: ## Stops and removes the running container.
	docker stop $(NAME)
	docker rm $(NAME)

help: ## Displays these usage instructions.
	@echo "Usage: make <target(s)>"
	@echo
	@echo "Specify one or multiple of the following targets and they will be processed in the given order:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "%-16s%s\n", $$1, $$2}' $(MAKEFILE_LIST)

all: build run test clean ## Equivalent to "make build run test clean"
