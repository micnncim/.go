# .go

A template repository for Go.

## Setup

```
$ git clone https://github.com/micnncim/.go repo
$ cd repo
$ rm -rf .git
$ git init
$ git remote add origin https://github.com/owner/repo
$ rm -f README.md
$ mv README.tmpl.md README.md
$ fd -E .git -X sd '<<OWNER>>' 'owner'
$ fd -E .git -X sd '<<PROJECT>>' 'repo'
$ fd -E .git -X sd '<<YEAR>>' '2020'
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
  format                         Run all formatters.
  lint                           Run all linters.
  clean                          Clean up cache.
  tools/update                   Update binaries managed by tools.
  docker/build                   Build docker image.
  docker/push                    Push docker image to docker registry.
  license                        Add license header to files.

```

