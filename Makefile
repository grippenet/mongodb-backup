
DOCKER_ORG ?= grippenet
DOCKER_REPO ?= mongodb-backup
VERSION ?= $(shell git describe --tags --abbrev=0)

build:
	docker build -t $(DOCKER_ORG)/$(DOCKER_REPO):$(VERSION) .

run:
	docker run --rm -it $(DOCKER_ORG)/$(DOCKER_REPO):$(VERSION)