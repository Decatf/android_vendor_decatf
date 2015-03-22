# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/decatf/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/decatf/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/decatf/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/decatf/prebuilt/bin/blacklist:system/addon.d/blacklist

# Init script file with custom extras
PRODUCT_COPY_FILES += \
 vendor/custom/prebuilt/etc/init.local.rc:root/init.custom.rc

# init.d support
PRODUCT_COPY_FILES += \
    vendor/decatf/prebuilt/bin/sysinit:system/bin/sysinit

PRODUCT_PACKAGES += \
    Launcher3 \
    Terminal

# Parts from CM-12.0 
PRODUCT_PACKAGES += \
    CMFileManager \
    DSPManager \
    javax.btobex \
    powertop

# CM-12.0 ffmpeg
#PRODUCT_COPY_FILES += \
#    frameworks/av/media/libstagefright/data/media_codecs_ffmpeg.xml:system/etc/media_codecs_ffmpeg.xml \

# Stagefright FFMPEG plugin
#PRODUCT_PACKAGES += \
#    libstagefright_soft_ffmpegadec \
#    libstagefright_soft_ffmpegvdec \
#    libFFmpegExtractor \
#    libnamparser

# Chromium Prebuilt
ifeq ($(USE_PREBUILT_CHROMIUM),1)
    $(call inherit-product, prebuilts/chromium/p4wifi/chromium_prebuilt.mk)
endif

-include vendor/decatf/sepolicy/sepolicy.mk
