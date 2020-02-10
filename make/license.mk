# ----------------------------------------------------------------------------
# include

$(call _conditional_include,$(MAKE)/tools.mk)

# ----------------------------------------------------------------------------
# targets

.PHONY: license
license: tools/bin/addlicense ## Add license header to files.
	addlicense -c <<OWNER>> .

