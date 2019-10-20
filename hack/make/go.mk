# ----------------------------------------------------------------------------
# global

ifneq ($(shell command -v go),)
GOPATH ?= $(shell go env GOPATH)
GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
endif

GO111MODULE := on
CGO_ENABLED ?= 0

DOCKER_BUILD_ARGS ?=
DOCKER_BUILD_TARGET ?= ${APP}
DOCKER_REGISTRY ?= index.docker.io
DOCKER_BUILD_TAG ?= latest

# ----------------------------------------------------------------------------
# targets

## build and install

.PHONY: install
install:
	CGO_ENABLED=$(CGO_ENABLED) GOOS=$(GOOS) GOARCH=$(GOARCH) go install -v $(CMD)

## dep

.PHONY: dep
dep:
	go mod download
	go mod verify
	go mod tidy

## test

.PHONY: test
test: lint ## Run test go files.
	go test -race ./...

.PHONY: coverage
coverage: ## Measure coverage for go files.
	go test -coverpkg ./... -covermode=atomic -coverprofile=coverage.txt -race ./...

## lint

.PHONY: lint
lint: lint/vet lint/golangci-lint ## Run all linters for go files.

.PHONY: lint/vet
lint/vet: ## Run go vet.
	go vet ./...

.PHONY: cmd/golangci-lint
cmd/golangci-lint: $(GOPATH)/bin/golangci-lint ## Check existence of golangci-lint.

.PHONY: lint/golangci-lint
lint/golangci-lint: cmd/golangci-lint ## Run golangci-lint.
	golangci-lint run ./...

## clean

.PHONY: clean
clean:  ## Clean up cache.
	go clean -cache

## docker

.PHONY: docker/build
docker/build:  ## Create docker image.
	docker image build ${DOCKER_BUILD_ARGS} --target ${DOCKER_BUILD_TARGET} -t $(DOCKER_REGISTRY)/$(APP):${DOCKER_BUILD_TAG} .

.PHONY: docker/push
docker/push:  ## Push docker image to docker registry.
	docker image push $(DOCKER_REGISTRY)/$(APP):$(VERSION)
