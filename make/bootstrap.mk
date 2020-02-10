# ----------------------------------------------------------------------------
# defines

define _conditional_include
	$(if $(filter $(1),$(MAKEFILE_LIST)),,$(eval include $(1)))
endef

