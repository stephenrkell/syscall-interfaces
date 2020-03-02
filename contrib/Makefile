THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))
CONTRIB := $(realpath $(dir $(THIS_MAKEFILE)))

CONFIG_MK += include $(CONTRIB)/dwarfidl/contrib/config.mk\n

.PHONY: default
default: env.sh config.mk build-dwarfidl

# ----------------------------dwarfidl

.PHONY: build-dwarfidl
build-dwarfidl: dwarfidl/lib/libdwarfidl.so

dwarfidl/config.status: dwarfidl/contrib/env.sh dwarfidl/configure
	cd dwarfidl && . contrib/env.sh && ./configure --prefix=/usr/local

dwarfidl/configure:
	cd dwarfidl && ./autogen.sh

dwarfidl/contrib/env.sh:
	$(MAKE) -C dwarfidl/contrib

dwarfidl/lib/libdwarfidl.so: dwarfidl/config.status
	$(MAKE) -C dwarfidl

export DWARFIDL_DIR := $(CONTRIB)/dwarfidl

# ----------------------------

varlist := DWARFIDL_DIR

CONFIG_MK += \n\nenv.sh:\n\tprintf '"'"'$(foreach var,$(varlist),export $(var)="$$($(var))"; )'"'"' >"$$@" || (rm -f "$$@"; false)

config.mk:
	printf '$(CONFIG_MK)' > "$@" || (rm -f "$@"; false)

env.sh: config.mk build-dwarfidl # because our config.mk includes dwarfidl's
	$(MAKE) -f "$<" "$@"

clean::
	rm -f config.mk env.sh
