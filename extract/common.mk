#!/usr/bin/make -f

-include config.mk

ifneq ($(realpath $(DWARFIDL_DIR)/src/dwarfhpp),)
DWARFHPP ?= $(DWARFIDL_DIR)/src/dwarfhpp
else
DWARFHPP ?= dwarfhpp
endif
