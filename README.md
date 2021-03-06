# .go

A template repository for Go.

## Setup

```console
$ git clone https://github.com/micnncim/.go PROJECT && cd $_
$ ./init.sh OWNER PROJECT
$ rm init.sh
$ # Remove Dockerfile etc. as necessary
```

## Development commands

```console
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
  format                         Run all formatters.
  lint                           Run all linters.
  clean                          Clean up cache.
  tools/update                   Update binaries managed by tools.
  docker/build                   Build docker image.
  docker/push                    Push docker image to docker registry.
  license                        Add license header to files.

```
