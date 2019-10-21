# ----------------------------------------------------------------------------
# global

ifneq ($(shell command -v go),)
GOPATH ?= $(shell go env GOPATH)
GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
endif

GO111MODULE := on
CGO_ENABLED ?= 0

# ----------------------------------------------------------------------------
# targets

## build and install

.PHONY: install
install:
	CGO_ENABLED=$(CGO_ENABLED) GOOS=$(GOOS) GOARCH=$(GOARCH) go install -v $(CMD)

## dep

.PHONY: dep
dep: ## Install dependencies as go modules.
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
cmd/golangci-lint: $(GOPATH)/bin/golangci-lint # Check existence of golangci-lint.

.PHONY: lint/golangci-lint
lint/golangci-lint: cmd/golangci-lint ## Run golangci-lint.
	golangci-lint run ./...

## clean

.PHONY: clean
clean:  ## Clean up cache.
	go clean -cache
