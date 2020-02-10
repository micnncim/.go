# ----------------------------------------------------------------------------
# global

ifneq ($(shell command -v go),)
GOPATH ?= $(shell go env GOPATH)
GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
endif

GO111MODULE := on
CGO_ENABLED ?= 0

GOTEST ?= go test

# ----------------------------------------------------------------------------
# targets

## all

.PHONY: all
all: test

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
	$(GOTEST) -v -race ./...

.PHONY: coverage
coverage: ## Measure coverage for Go files.
	$(GOTEST) -coverpkg ./... -covermode=atomic -coverprofile=coverage.txt -race ./...

## lint

.PHONY: lint
lint: lint/vet lint/golint lint/golangci-lint ## Run all linters for Go files.

.PHONY: lint/vet
lint/vet: ## Run go vet.
	go vet ./...

.PHONY: lint/golint
lint/golint: tools/bin/golint ## Run golint.
	golint ./...

.PHONY: lint/golangci-lint
lint/golangci-lint: tools/bin/golangci-lint ## Run golangci-lint.
	golangci-lint run ./...

## tools

.PHONY: tools/update
tools/update: ## Update binaries managed by tools.
	cd tools && go mod tidy

tools/bin/golint: tools/go.mod tools/go.sum
	cd tools && go build -o bin/golint golang.org/x/lint/golint

tools/bin/golangci-lint: tools/go.mod tools/go.sum
	cd tools && go build -o bin/golangci-lint github.com/golangci/golangci-lint/cmd/golangci-lint

## clean

.PHONY: clean
clean:  ## Clean up cache.
	go clean -cache
