ENV_FILE := .env
ENV = $(shell cat $(ENV_FILE))
ENV_LOCAL_FILE := go/env.local
ENV_LOCAL = $(shell cat $(ENV_LOCAL_FILE))

up:
	$(ENV) $(ENV_LOCAL) docker-compose up
down:
	$(ENV) $(ENV_LOCAL) docker-compose down
build:
	$(ENV) $(ENV_LOCAL) docker-compose build
