SHELL := /bin/bash
CWD   := $(shell pwd)
IMAGE := "r-base:latest"
SOME_CONTAINER := $(shell echo some-$(IMAGE) | sed 's/[^a-zA-Z0-9]//g')
DOCKERFILE     := $(CWD)/Dockerfile

.PHONY: all
all: clean test build

.PHONY: build
build:
	@docker build -t $(IMAGE) -f $(DOCKERFILE) $(CWD)
	@echo built $(IMAGE)

.PHONY: pull
pull:
	@docker pull $(IMAGE)
	@echo pulled $(IMAGE)

.PHONY: push
push:
	@docker push $(IMAGE)
	@echo pushed $(IMAGE)

.PHONY: run
run:
	@docker run --name $(SOME_CONTAINER) --rm $(IMAGE)
	@echo ran $(IMAGE)

.PHONY: ssh
ssh:
	@docker run -it $(IMAGE) $(SHELL)

.PHONY: test
test:
	@rspec Dockerfile_spec.rb

.PHONY: clean
clean:
	-@docker rmi -f $(IMAGE) 
	@echo cleaned
