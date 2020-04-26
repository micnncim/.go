# .go

A template repository for Go.

## Setup

```console
$ OWNER=
$ REPO=
$ git clone https://github.com/micnncim/.go ${REPO} && cd $_
$ rm -rf .git
$ git init
$ git remote add origin https://github.com/${OWNER}/${REPO}
$ rm -f README.md
$ mv README.tmpl.md README.md
$ fd -E .git -X sd '<<OWNER>>' ${OWNER}
$ fd -E .git -X sd '<<PROJECT>>' ${REPO}
$ fd -E .git -X sd '<<YEAR>>' $(date '+%Y')
$ fd .gitkeep -X rm
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

