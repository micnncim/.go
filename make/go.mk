# ----------------------------------------------------------------------------
# global

ifneq ($(shell command -v go),)
GOPATH ?= $(shell go env GOPATH)
GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
endif

GO111MODULE := on
CGO_ENABLED ?= 0
BIN := bin

GO_TEST ?= go test

# ----------------------------------------------------------------------------
# targets

## all

.PHONY: all
all: test build

## build and install

.PHONY: build
build: dep ## Build a Go application.
	CGO_ENABLED=$(CGO_ENABLED) GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(BIN)/$(APP) $(CMD)

.PHONY: install
install: dep ## Install a binary into $GOPATH/bin.
	CGO_ENABLED=$(CGO_ENABLED) GOOS=$(GOOS) GOARCH=$(GOARCH) go install -v $(CMD)

## dep

.PHONY: dep
dep: ## Install dependencies as Go Modules.
	go mod download
	go mod verify
	go mod tidy

## test

.PHONY: test
test: lint ## Run test Go files.
	$(GO_TEST) -v -race ./...

.PHONY: coverage
coverage: ## Measure coverage for Go files.
	go test -coverpkg ./... -covermode=atomic -coverprofile=coverage.txt -race ./...

## lint

.PHONY: lint
lint: lint/vet lint/golangci-lint ## Run all linters for Go files.

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
