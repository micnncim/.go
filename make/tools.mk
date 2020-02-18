# ----------------------------------------------------------------------------
# targets

## tools

.PHONY: tools/update
tools/update: ## Update binaries managed by tools.
	cd tools && go mod tidy

### installation of tools

tools/bin/gofumpt: tools/go.mod tools/go.sum
	cd tools && go build -o bin/gofumpt mvdan.cc/gofumpt

tools/bin/golint: tools/go.mod tools/go.sum
	cd tools && go build -o bin/golint golang.org/x/lint/golint

tools/bin/golangci-lint: tools/go.mod tools/go.sum
	cd tools && go build -o bin/golangci-lint github.com/golangci/golangci-lint/cmd/golangci-lint

tools/bin/addlicense: tools/go.mod tools/go.sum
	cd tools && go build -o bin/addlicense github.com/google/addlicense

