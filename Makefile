.PHONY: help pull-image build-image rebuild-image run stop open ps images shell migrate
.DEFAULT_GOAL := help

BASE_IMAGE=robertobutti/php-8.0-apache:php8.0.0
LARAVEL_IMAGE=php8.0-laravel
HTTP_PORT=8100

help: ## Show this Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)  | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

pull-image: ## Update base image
	docker pull ${IMAGE}


build-image: ## Build docker image
	docker build . --tag {LARAVEL_IMAGE}

rebuild-image: pull-image build-image ## Reuild docker image from scratch

run: ## Run all services via docker-compose
	docker-compose up -d

stop: ## Stop all services via docker-compose
	docker-compose down

open: ## Open Browser
	open  http://127.0.0.1:${HTTP_PORT}/

ps: ## List running containers
	docker ps

images: ## List docker images
	docker images

shell: ## Execute shell from docker image
	docker-compose exec web bash

migrate: ## Execute artisan migrate command inside docker image
	docker-compose exec web php artisan migrate
