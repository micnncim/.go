# ----------------------------------------------------------------------------
# global

.DEFAULT_GOAL = all

# MAKE is a directory which contains .mk files.
MAKE := make

APP := <<PROJECT>>

# ----------------------------------------------------------------------------
# include

include make/bootstrap.mk
include make/go.mk
include make/docker.mk
include make/license.mk

# ----------------------------------------------------------------------------
# targets

.PHONY: help
help:  ## Show make target help.
	@perl -nle 'BEGIN {printf "\nUsage:\n  make \033[33m<target>\033[0m\n\nTargets:\n"} printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2 if /^([a-zA-Z\/_-].+)+:.*?\s+## (.*)/' ${MAKEFILE_LIST}
