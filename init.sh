#!/bin/bash

set -e

usage() {
    cat <<EOF
  $(basename ${0}) initiliazes the repository created by "micnncim/.go".

  Usage:
      $(basename ${0}) OWNER PROJECT
EOF
}

main() {
    owner=$1
    if [[ -z "${owner}" ]]; then
        echo "[ERROR] missing owner name" >&2
        usage
        exit 1
    fi

    project=$2
    if [[ -z "${project}" ]]; then
        echo "[ERROR] missing project name" >&2
        usage
        exit 1
    fi

    rm -rf .git
    git init
    git remote add origin "https://github.com/${owner}/${project}"

    rm -f README.md
    mv README.tmpl.md README.md

    find . -type f -name '.gitkeep' -exec rm {} \;

    find . -type f -not -path '*/.git/*' -exec sed -i -e "s/<<OWNER>>/${owner}/g" {} \;
    find . -type f -not -path '*/.git/*' -exec sed -i -e "s/<<PROJECT>>/${project}/g" {} \;
    find . -type f -not -path '*/.git/*' -exec sed -i -e "s/<<YEAR>>/$(date '+%Y')/g" {} \;
}

main "$@"
