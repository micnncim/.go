# ----------------------------------------------------------------------------
# targets

.PHONY: license
license: ## Add license header to files.
	addlicense -v -c <<OWNER>>

