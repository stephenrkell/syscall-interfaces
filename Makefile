.PHONY: default install all

default: install

# before going any further, ensure we've copied in the kernel images
# to avoid asking for sudo halfway through
all install: ensure_kernel_images

.PHONY: ensure_kernel_images
ensure_kernel_images:
	$(MAKE) -C scripts -f kernel-objects.mk ensure_kernel_images

############################################################ Submodules

scripts/%: | install_submodules_libdwarfpp install_submodules_liballocs
	$(MAKE) -C scripts -f kernel-objects.mk "$*"

