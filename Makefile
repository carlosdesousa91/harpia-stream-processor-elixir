.DEFAULT_GOAL := help

.PHONY: help ## Prints this help message
help:
	@echo "========================================================================================"
	@echo "Makefile: Use 'make <target>' where <target> is one of the following commands:\n"
	@grep -E '^\.PHONY: [a-zA-Z_-]+ .*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = "(: |##)"}; {printf "\033[36m%-15s\033[0m %s\n", $$2, $$3}'
	@echo "========================================================================================"
	@echo ""

.PHONY: build ## docker-compose build
build:
	docker-compose build

.PHONY: up-kafka ## docker-compose up for kafka containers
up-kafka:
	docker-compose up -d harpia_db_elx zookeeper kafka kafdrop cmak

.PHONY: run-ingestion ## docker-compose run for harpia_ingestion_ex with iex
run-ingestion:
	@echo "========================================================================================"
	@echo "This will run harpia_ingestion_ex, with an iex terminal prompt"
	@echo "To test the application, run:"
	@echo 'ExampleProducer.send_my_message({"Metamorphosis", "Franz Kafka"}, "another_topic")'
	@echo "========================================================================================"
	@echo ""
	docker-compose run harpia_ingestion_ex iex -S mix