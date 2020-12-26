################################################################################
#
# libbpf
#
################################################################################

LIBBPF_VERSION = v0.2
LIBBPF_SITE = $(call github,libbpf,libbpf,$(LIBBPF_VERSION))
LIBBPF_LICENSE = LGPL-2.1 or BSD-2-Clause
LIBBPF_LICENSE_FILES = LICENSE
LIBBPF_DEPENDENCIES = zlib elfutils
LIBBPF_CFLAGS = "-g -O2 -Werror -Wall -I$(TARGET_DIR)/usr/include"
LIBBPF_INSTALL_PREFIX = "$(TARGET_DIR)/usr"

LIBBPF_ENV = \
		PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
		PKG_CONFIG_LIBDIR="$(TARGET_DIR)/usr/lib/pkgconfig" \
		LIBDIR="$(TARGET_DIR)/usr/lib" \
		INCLUDEDIR="$(TARGET_DIR)/usr/include" \
		UAPIDIR="$(TARGET_DIR)/usr/include/uapi"

define LIBBPF_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(LIBBPF_ENV) $(MAKE) -C $(@D)/src CC=$(TARGET_CC) BUILD_STATIC_ONLY=1 CFLAGS=$(LIBBPF_CFLAGS) 
endef


define LIBBPF_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(LIBBPF_ENV) $(MAKE) -C $(@D)/src CC=$(TARGET_CC) BUILD_STATIC_ONLY=1 CFLAGS=$(LIBBPF_CFLAGS) install
	$(TARGET_MAKE_ENV) $(LIBBPF_ENV) $(MAKE) -C $(@D)/src CC=$(TARGET_CC) BUILD_STATIC_ONLY=1 CFLAGS=$(LIBBPF_CFLAGS) install_uapi_headers
endef


$(eval $(generic-package))
