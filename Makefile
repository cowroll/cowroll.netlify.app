MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := run

BUILD_DIR=build

# all targets are phony
.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')

ifneq ("$(wildcard ./.env)","")
  include ./.env
endif

run: ## Run Server
	lektor server -h 0.0.0.0

build: ## Build contents
	lektor build --output-path=${BUILD_DIR}

#deploy-netlify: gen
# ./deploy.sh
deploy: ## Deploy server
	lektor deploy production --key ${TOKEN}

#deploy: deploy-netlify commit-push

clean: ## Clean cache
	lektor clean

auth-netlify:
	netlify deploy -d ${BUILD_DIR}

#deploy:
#	netlify deploy --prod

deploy:
	netlify deploy --prod -d ${BUILD_DIR} -a ${TOKEN} -s ${SITE}

foo:
	yarn netlify deploy --prod -d dist -a [AUTH_TOKEN] -s [SITE_ID]
	yarn netlify deploy --prod -d dist -a ${NETLIFY_AUTH_TOKEN} -s ${NETLIFY_SITE_ID}


help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
