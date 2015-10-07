# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/decatf/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/decatf/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/decatf/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/decatf/prebuilt/bin/blacklist:system/addon.d/blacklist


PRODUCT_PACKAGE_OVERLAYS += vendor/decatf/overlay/common

# Init script file with custom extras
PRODUCT_COPY_FILES += \
	vendor/decatf/prebuilt/etc/init.local.rc:root/init.custom.rc

# init.d support
PRODUCT_COPY_FILES += \
    vendor/decatf/prebuilt/bin/sysinit:system/bin/sysinit

PRODUCT_PACKAGES += \
    Launcher3

PRODUCT_PACKAGES += \
	liblog-benchmarks \
	bionic-benchmarks

# Chromium Prebuilt
ifeq ($(USE_PREBUILT_CHROMIUM),1)
    $(call inherit-product, prebuilts/chromium/p4wifi/chromium_prebuilt.mk)
endif

-include vendor/decatf/sepolicy/sepolicy.mk

# Android system toolchain
# TARGET_GCC_VERSION_EXP := 4.8
# TARGET_TOOLCHAIN_ROOT := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/linaro-arm-eabi-$(TARGET_GCC_VERSION)
# TARGET_TOOLS_PREFIX := $(TARGET_TOOLCHAIN_ROOT)/bin/arm-linux-gnueabi-

# Kernel toolchain
# TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-eabi-4.6
TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-eabi-4.8
# TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-eabi-5.1
# TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-cortex-linux-gnueabi-linaro_4.9.3-2015.03
# TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-cortex-linux-gnueabi-linaro_4.9.4-2015.06

# Add backup-tool.sh to install script
BACKUP_TOOL := true
