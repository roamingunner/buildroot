################################################################################
#
# libbpf
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBBPF_STANDALONE_VESION),y)
LIBBPF_VERSION = v0.2
LIBBPF_SITE = $(call github,libbpf,libbpf,$(LIBBPF_VERSION))
LIBBPF_LICENSE = LGPL-2.1 or BSD-2-Clause
LIBBPF_LICENSE_FILES = LICENSE
LIBBPF_DEPENDENCIES = zlib elfutils
LIBBPF_CFLAGS = "-g -O2 -Werror -Wall -I$(STAGING_DIR)/usr/include"
LIBBPF_INSTALL_PREFIX = "$(STAGING_DIR)/usr"
LIBBPF_INSTALL_STAGING = YES
LIBBPF_INSTALL_TARGET = NO
LIBBPF_ENV = \
		PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
		PKG_CONFIG_LIBDIR="$(STAGING_DIR)/usr/lib/pkgconfig" \
		LIBDIR="$(STAGING_DIR)/usr/lib" \
		INCLUDEDIR="$(STAGING_DIR)/usr/include" \
		UAPIDIR="$(STAGING_DIR)/usr/include/uapi"

define LIBBPF_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(LIBBPF_ENV) $(MAKE) -C $(@D)/src CC=$(TARGET_CC) BUILD_STATIC_ONLY=1 CFLAGS=$(LIBBPF_CFLAGS) 
endef


define LIBBPF_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(LIBBPF_ENV) $(MAKE) -C $(@D)/src CC=$(TARGET_CC) BUILD_STATIC_ONLY=1 CFLAGS=$(LIBBPF_CFLAGS) install
	$(TARGET_MAKE_ENV) $(LIBBPF_ENV) $(MAKE) -C $(@D)/src CC=$(TARGET_CC) BUILD_STATIC_ONLY=1 CFLAGS=$(LIBBPF_CFLAGS) install_uapi_headers
endef

else ifeq ($(BR2_PACKAGE_LIBBPF_LINUX_KERNEL_VERSION),y)

LIBBPF_VERSION = head
LIBBPF_SITE = $(LINUX_DIR)/tools/bpf
LIBBPF_SITE_METHOD = local
LIBBPF_LICENSE = LGPL-2.1 or BSD-2-Clause
LIBBPF_LICENSE_FILES = LICENSE
LIBBPF_DEPENDENCIES = zlib elfutils binutils linux 
LIBBPF_CFLAGS = "-g -O2 -Werror -Wall -I$(STAGING_DIR)/usr/include"
LIBBPF_INSTALL_PREFIX = "$(STAGING_DIR)/usr"
LIBBPF_INSTALL_STAGING = YES
LIBBPF_INSTALL_TARGET = NO

LIBBPF_TARGET_ENV = \
		PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
		PKG_CONFIG_LIBDIR="$(STAGING_DIR)/usr/lib/pkgconfig"

LIBBPF_TARGET_VARIABLES = \
		ARCH=$(KERNEL_ARCH) \
		CC=$(TARGET_CC) \
		LD=$(TARGET_LD) \
		CROSS_COMPILE=$(TARGET_CROSS) \
		VMLINUX_BTF=$(LINUX_DIR)/vmlinux \
		BPFTOOL=$(HOST_DIR)/sbin/bpftool \
		BPFTOOL_BOOTSTRAP=$(HOST_DIR)/sbin/bpftool-bootstrap

LIBBPF_HOST_ENV = \
		PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
		PKG_CONFIG_LIBDIR="$(HOST_DIR)/lib/pkgconfig" \
		DESTDIR=$(HOST_DIR) \
		prefix=/usr

define LIBBPF_BUILD_CMDS
	$(LINUX_MAKE_ENV) $(MAKE) $(LINUX_MAKE_FLAGS) INSTALL_HDR_PATH=$(STAGING_DIR) -C $(LINUX_DIR) headers_install
	$(HOST_MAKE_ENV) $(MAKE) -C $(LINUX_DIR)/tools/bpf clean
	$(HOST_MAKE_ENV) $(MAKE) VMLINUX_BTF=$(LINUX_DIR)/vmlinux -C $(LINUX_DIR)/tools/bpf 
	$(HOST_MAKE_ENV) $(MAKE) VMLINUX_BTF=$(LINUX_DIR)/vmlinux -C $(LINUX_DIR)/tools/bpf install
endef


define LIBBPF_INSTALL_STAGING_CMDS
endef

endif

# LIBDIR="$(STAGING_DIR)/usr/lib" \
# INCLUDEDIR="$(STAGING_DIR)/usr/include" \
# UAPIDIR="$(STAGING_DIR)/usr/include/uapi"
#
	# $(LINUX_MAKE_ENV) $(MAKE) $(LINUX_MAKE_FLAGS) INSTALL_HDR_PATH=$(STAGING_DIR) -C $(LINUX_DIR) headers_install
	# echo "build for host..........................."
	# $(LIBBPF_HOST_ENV) $(MAKE) -C $(LINUX_DIR)/tools/bpf clean
	# $(LIBBPF_HOST_ENV) $(MAKE) -C $(LINUX_DIR)/tools/bpf bpftool 
	# $(LIBBPF_HOST_ENV) $(MAKE) -C $(LINUX_DIR)/tools/bpf bpftool_install
	# $(LIBBPF_HOST_ENV) $(MAKE) -C $(LINUX_DIR)/tools/bpf/bpftool bpftool-bootstrap
	# $(INSTALL) $(LINUX_DIR)/tools/bpf/bpftool/bpftool-bootstrap $(HOST_DIR)/sbin/bpftool-bootstrap
	
	# echo "build for target..........................."
	# $(TARGET_MAKE_ENV) $(LIBBPF_TARGET_ENV) $(MAKE) $(LIBBPF_TARGET_VARIABLES) -C $(LINUX_DIR)/tools/bpf clean
	# $(TARGET_MAKE_ENV) $(LIBBPF_TARGET_ENV) $(MAKE) $(LIBBPF_TARGET_VARIABLES) -C $(LINUX_DIR)/tools/bpf 

$(eval $(generic-package))
