# ----------------------------------------------------------------------------
# global

DOCKER_BUILD_ARGS ?=
DOCKER_BUILD_TARGET ?= ${APP}
DOCKER_REGISTRY ?= docker.io
DOCKER_BUILD_TAG ?= latest

# ----------------------------------------------------------------------------
# targets

.PHONY: docker/build
docker/build:  ## Build docker image.
	@docker image build . ${DOCKER_BUILD_ARGS} -t $(DOCKER_REGISTRY)/$(APP):${DOCKER_BUILD_TAG}

.PHONY: docker/push
docker/push:  ## Push docker image to docker registry.
	@docker image push $(DOCKER_REGISTRY)/$(APP):$(VERSION)

