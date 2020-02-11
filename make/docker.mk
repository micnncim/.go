# ----------------------------------------------------------------------------
# global

DOCKER_BUILD_ARGS ?=
DOCKER_BUILD_TARGET ?= ${APP}
DOCKER_REGISTRY ?= index.docker.io
DOCKER_BUILD_TAG ?= latest

# ----------------------------------------------------------------------------
# targets

.PHONY: docker/build
docker/build:  ## Build docker image.
ifeq ($(DOCKER_BUILDKIT),1)
	buildctl build \
		--frontend dockerfile.v0 \
		--local context=. \
		--local dockerfile=. \
		--output type=image,name=$(DOCKER_REGISTRY)/$(APP):${DOCKER_BUILD_TAG}
else
	docker image build . \
		${DOCKER_BUILD_ARGS} \
		-t $(DOCKER_REGISTRY)/$(APP):${DOCKER_BUILD_TAG}
endif

.PHONY: docker/push
docker/push:  ## Push docker image to docker registry.
	docker image push $(DOCKER_REGISTRY)/$(APP):$(VERSION)

