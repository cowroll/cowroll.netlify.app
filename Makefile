MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := run

# all targets are phony
.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')

ifneq ("$(wildcard ./.env)","")
  include ./.env
endif

run: ## Run Server
	lektor server -h 0.0.0.0

build: ## Build contents
	lektor build --output-path=build

#deploy-netlify: gen
# ./deploy.sh
deploy: ## Deploy server
	lektor deploy production --key ${TOKEN}

#deploy: deploy-netlify commit-push

clean: ## Clean cache
	lektor clean

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
