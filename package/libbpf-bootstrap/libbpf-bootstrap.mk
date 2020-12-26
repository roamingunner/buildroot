################################################################################
#
# libbpf-bootstrap
#
################################################################################

LIBBPF_BOOTSTRAP_VERSION = 4999ed86de09cdd75d9ca982d36419bb3de296c8
LIBBPF_BOOTSTRAP_SITE = $(call github,libbpf,libbpf-bootstrap,$(LIBBPF_BOOTSTRAP_VERSION))
LIBBPF_BOOTSTRAP_LICENSE = LGPL-2.1 or BSD-2-Clause
LIBBPF_BOOTSTRAP_LICENSE_FILES = LICENSE
LIBBPF_BOOTSTRAP_DEPENDENCIES = libbpf
LIBBPF_BOOTSTRAP_CFLAGS = "-g -O2 -Werror -Wall -I$(TARGET_DIR)/usr/include"
LIBBPF_BOOTSTRAP_INSTALL_PREFIX = "$(TARGET_DIR)/usr"

LIBBPF_BOOTSTRAP_ENV = \
		CC=$(TARGET_CC)  \
		CLANG=clang-10  \
		LLVM_STRIP=llvm-strip-10  \
		LIBBPF_SRC="$(BUILD_DIR)/libbpf-$(LIBBPF_VERSION)/src"  \
		LIBBPF_OBJ="$(TARGET_DIR)/usr/lib/libbpf.a"  \
		ARCH=$(BR2_ARCH)\
		INCLUDES="-I$(@D)/src/.output -I$(TARGET_DIR)/usr/include -I$(TARGET_DIR)/usr/include/uapi"

define LIBBPF_BOOTSTRAP_BUILD_CMDS
	$(TARGET_MAKE_ENV)  $(MAKE) -C $(@D)/src $(LIBBPF_BOOTSTRAP_ENV)
endef


define LIBBPF_BOOTSTRAP_INSTALL_TARGET_CMDS
	cp $(@D)/src/minimal $(TARGET_DIR)/usr/sbin/
	cp $(@D)/src/bootstrap  $(TARGET_DIR)/usr/sbin/
endef


$(eval $(generic-package))
