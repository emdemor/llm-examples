-include .env

export

PROJECT_NAME = llm-projects
PACKAGE_NAME = llm-projects

PWD := $(shell pwd)

DOCKER_IMG := $(PROJECT_NAME):latest
DOCKER_ENV := --env-file .env

DOCKER_RUN := docker run --rm -t

build-jupyter:
	docker build -f build/Dockerfile.jupyter -t $(DOCKER_IMG) .

start-jupyter: build-jupyter
	docker run --rm $(DOCKER_ENV) -v ./.jupyter:/root/.jupyter -v ./projects:/projects -i --gpus all -p 8888:8888 -t $(DOCKER_IMG)

shell: build
	docker run --rm $(DOCKER_ENV) -v ./projects:/projects -i --gpus all -p 8888:8888 -t $(DOCKER_IMG) /bin/bash
