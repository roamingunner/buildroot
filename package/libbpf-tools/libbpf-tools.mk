################################################################################
#
# libbpf-tools
#
################################################################################

LIBBPF_TOOLS_VERSION = v0.17.0
LIBBPF_TOOLS_SITE = $(call github,iovisor,bcc,$(LIBBPF_TOOLS_VERSION))
LIBBPF_TOOLS_LICENSE = Apache
LIBBPF_TOOLS_LICENSE_FILES = LICENSE.txt
LIBBPF_TOOLS_DEPENDENCIES = libbpf
LIBBPF_TOOLS_CFLAGS = "-g -O2 -Werror -Wall -I$(STAGING_DIR)/usr/include"

LIBBPF_TOOLS_ENV = \
		CC=$(TARGET_CC)  \
		CLANG=clang-10  \
		LLVM_STRIP=llvm-strip-10  \
		LIBBPF_SRC="$(BUILD_DIR)/libbpf-$(LIBBPF_VERSION)/src"  \
		LIBBPF_OBJ="$(STAGING_DIR)/usr/lib/libbpf.a"  \
		ARCH=$(BR2_ARCH)\
		INCLUDES="-I$(@D)/libbpf-tools/.output -I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/usr/include/uapi"

define LIBBPF_TOOLS_BUILD_CMDS
	$(TARGET_MAKE_ENV)  $(MAKE) -C $(@D)/libbpf-tools $(LIBBPF_TOOLS_ENV)
endef


define LIBBPF_TOOLS_INSTALL_TARGET_CMDS
	cp $(@D)/libbpf-tools/biolatency  $(TARGET_DIR)/usr/sbin/biolatency  
	cp $(@D)/libbpf-tools/biopattern  $(TARGET_DIR)/usr/sbin/biopattern  
	cp $(@D)/libbpf-tools/biosnoop    $(TARGET_DIR)/usr/sbin/biosnoop    
	cp $(@D)/libbpf-tools/biolatency  $(TARGET_DIR)/usr/sbin/biolatency  
	cp $(@D)/libbpf-tools/biopattern  $(TARGET_DIR)/usr/sbin/biopattern  
	cp $(@D)/libbpf-tools/biosnoop    $(TARGET_DIR)/usr/sbin/biosnoop    
	cp $(@D)/libbpf-tools/biostacks   $(TARGET_DIR)/usr/sbin/biostacks   
	cp $(@D)/libbpf-tools/bitesize    $(TARGET_DIR)/usr/sbin/bitesize    
	cp $(@D)/libbpf-tools/cpudist     $(TARGET_DIR)/usr/sbin/cpudist     
	cp $(@D)/libbpf-tools/drsnoop     $(TARGET_DIR)/usr/sbin/drsnoop     
	cp $(@D)/libbpf-tools/execsnoop   $(TARGET_DIR)/usr/sbin/execsnoop   
	cp $(@D)/libbpf-tools/filelife    $(TARGET_DIR)/usr/sbin/filelife    
	cp $(@D)/libbpf-tools/hardirqs    $(TARGET_DIR)/usr/sbin/hardirqs    
	cp $(@D)/libbpf-tools/llcstat     $(TARGET_DIR)/usr/sbin/llcstat     
	cp $(@D)/libbpf-tools/numamove    $(TARGET_DIR)/usr/sbin/numamove    
	cp $(@D)/libbpf-tools/opensnoop   $(TARGET_DIR)/usr/sbin/opensnoop   
	cp $(@D)/libbpf-tools/readahead   $(TARGET_DIR)/usr/sbin/readahead   
	cp $(@D)/libbpf-tools/runqlat     $(TARGET_DIR)/usr/sbin/runqlat     
	cp $(@D)/libbpf-tools/runqlen     $(TARGET_DIR)/usr/sbin/runqlen     
	cp $(@D)/libbpf-tools/runqslower  $(TARGET_DIR)/usr/sbin/runqslower  
	cp $(@D)/libbpf-tools/softirqs    $(TARGET_DIR)/usr/sbin/softirqs    
	cp $(@D)/libbpf-tools/syscount    $(TARGET_DIR)/usr/sbin/syscount    
	cp $(@D)/libbpf-tools/tcpconnect  $(TARGET_DIR)/usr/sbin/tcpconnect  
	cp $(@D)/libbpf-tools/tcpconnlat  $(TARGET_DIR)/usr/sbin/tcpconnlat  
	cp $(@D)/libbpf-tools/vfsstat     $(TARGET_DIR)/usr/sbin/vfsstat     
endef


$(eval $(generic-package))
