# .go

A template repository for Go.

## Setup

```
$ git clone https://github.com/micnncim/.go hello
$ cd hello
$ rm -rf .git
$ git init
$ git remote add origin https://github.com/eng/hello
$ fd -E .git -X sd '<<PROJECT>>' 'hello'
```

## Development commands

```
$ make help
Usage:
  make <target>

Targets:
  help                           Show make target help.
  build                          Build a Go application.
  install                        Install a binary into $GOPATH/bin.
  dep                            Install dependencies as Go Modules.
  test                           Run test Go files.
  coverage                       Measure coverage for Go files.
  lint                           Run all linters for Go files.
  lint/vet                       Run go vet.
  lint/golangci-lint             Run golangci-lint.
  clean                          Clean up cache.
  docker/build                   Build docker image.
```
