# ----------------------------------------------------------------------------
# global

CMD = cmd/$(APP)

ifneq ($(shell command -v go),)
GOPATH ?= $(shell go env GOPATH)
GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
endif

BIN ?= bin

GO111MODULE := on
CGO_ENABLED ?= 0

GOTEST ?= go test

# ----------------------------------------------------------------------------
# include

$(call _conditional_include,$(MAKE)/tools.mk)

# ----------------------------------------------------------------------------
# targets

## all

.PHONY: all
all: test

## build and install

.PHONY: build
build: dep ## Build a Go application.
	@CGO_ENABLED=$(CGO_ENABLED) GOOS=$(GOOS) GOARCH=$(GOARCH) go build -v -o $(BIN)/$(APP) $(CMD)/main.go

.PHONY: install
install: dep ## Install a binary into $GOPATH/bin.
	@CGO_ENABLED=$(CGO_ENABLED) GOOS=$(GOOS) GOARCH=$(GOARCH) go install -v $(CMD)

## dep

.PHONY: dep
dep: ## Install dependencies as Go Modules.
	@go mod download

## test

.PHONY: test
test: format lint ## Run test Go files.
	@$(GOTEST) -v -race ./...

.PHONY: coverage
coverage: ## Measure coverage for Go files.
	@$(GOTEST) -coverpkg ./... -covermode=atomic -coverprofile=coverage.txt -race ./...

## format

.PHONY: format
format: format/gofumpt ## Run all formatters.

.PHONY: format/gofumpt
format/gofumpt: tools/bin/gofumpt ### Run gofumpt.
	@gofumpt -w .

## lint

.PHONY: lint
lint: lint/vet lint/golint lint/golangci-lint ## Run all linters.

.PHONY: lint/vet
lint/vet:
	@go vet ./...

.PHONY: lint/golint
lint/golint: tools/bin/golint
	@golint ./...

.PHONY: lint/golangci-lint
lint/golangci-lint: tools/bin/golangci-lint
	@golangci-lint run ./...

## clean

.PHONY: clean
clean:  ## Clean up cache.
	@go clean -cache
