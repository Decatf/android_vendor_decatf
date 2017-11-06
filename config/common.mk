# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/decatf/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/decatf/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/decatf/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/decatf/prebuilt/bin/blacklist:system/addon.d/blacklist


PRODUCT_PACKAGE_OVERLAYS += vendor/decatf/overlay/common

# Init script file with custom extras
PRODUCT_COPY_FILES += \
    vendor/decatf/prebuilt/etc/init.local.rc:root/init.custom.rc

# init.d support
PRODUCT_COPY_FILES += \
    vendor/decatf/prebuilt/bin/sysinit:system/bin/sysinit \
    vendor/decatf/prebuilt/etc/init.d/01_dummy:system/etc/init.d/01_dummy \

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/decatf/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# disable systemless supersu
PRODUCT_COPY_FILES += \
    vendor/decatf/prebuilt/supersu_config:system/supersu_config

PRODUCT_COPY_FILES += \
	vendor/decatf/prebuilt/bin/set_hwui_params.sh:system/vendor/bin/set_hwui_params.sh

 PRODUCT_PACKAGES += \
     Launcher3 \
     busybox \
     WallpaperPicker \
     Apollo

# substratum themes
PRODUCT_PACKAGES += \
    ThemeInterfacer

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

PRODUCT_PACKAGES += \
    liblog-benchmarks \
    bionic-benchmarks

PRODUCT_PACKAGES += \
	libtcg_arm \
	libjaunt

-include vendor/decatf/sepolicy/sepolicy.mk

# Kernel toolchain
# TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-eabi-4.6
# TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-eabi-4.8
TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-linux-androidkernel-

# Linaro
# TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-cortex-linux-gnueabi-
# KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/arm/arm-cortex-linux-gnueabi-linaro_4.9.4-2015.06/bin

# TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-eabi-
# KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin
