MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := run

ifneq ("$(wildcard ./.env)","")
  include ./.env
endif

run: ## Run server
	@gatsby develop

build: ## Build site on public directory
	@gatsby build

clean: ## Clean cache, public directory
	@gatsby clean

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
