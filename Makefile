# By default, we generate a dwarfidl description of the interface of
# the currently running kernel.
THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))
srcroot := $(realpath $(dir $(THIS_MAKEFILE)))
SYS := $(shell uname -s | tr A-Z a-z )

.PHONY: default
default: contrib lib/$(SYS)-syscall-addrs lib/$(SYS)-syscalls.list

.PHONY: contrib
contrib:
	$(MAKE) -C contrib

# sysfoot (and maybe other tools) can be used to help maintain, manually,
# an expanded spec. Ideally dwarfidl would support "separate annotation"
# but maybe it can just be a diff for now.

lib/$(SYS)-syscalls.list lib/$(SYS)-syscall-macros.h:
	mkdir -p lib && cd lib && $(MAKE) -f $(srcroot)/extract/$(SYS)/extract
