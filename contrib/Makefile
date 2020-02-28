THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))
CONTRIB := $(realpath $(dir $(THIS_MAKEFILE)))

CONFIG_MK += include $$(dir $$(lastword $$(MAKEFILE_LIST)))/dwarfidl/contrib/config.mk

default: env.sh config.mk build-dwarfidl \
  build-libfootprints

# ----------------------------dwarfidl

dwarfidl/config.status: dwarfidl/contrib/env.sh
	cd dwarfidl && ./contrib/env.sh && ./configure --prefix=/usr/local

dwarfidl/contrib/env.sh:
	$(MAKE) -C dwarfidl/contrib

dwarfidl/lib/libdwarfidl.so: dwarfidl/config.status
	$(MAKE) -C dwarfidl

# ----------------------------

varlist := DWARFIDL_DIR

CONFIG_MK += \n\nenv.sh:\n\tprintf '"'"'$(foreach var,$(varlist),export $(var)="$$($(var))"; )'"'"' >"$$@" || (rm -f "$$@"; false)

config.mk:
	printf '$(CONFIG_MK)' > "$@" || (rm -f "$@"; false)

env.sh: config.mk
	$(MAKE) -f "$<" "$@"

clean::
	rm -f config.mk env.sh
