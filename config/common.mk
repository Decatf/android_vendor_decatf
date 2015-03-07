# Backup Tool
PRODUCT_COPY_FILES += \
	vendor/decatf/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
	vendor/decatf/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
	vendor/decatf/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
	vendor/decatf/prebuilt/bin/blacklist:system/addon.d/blacklist

# Parts from CM-12.0 
PRODUCT_PACKAGES += \
        CMFileManager \
        DSPManager \
        javax.btobex

# CM-12.0 ffmpeg
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_ffmpeg.xml:system/etc/media_codecs_ffmpeg.xml \

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libstagefright_soft_ffmpegadec \
    libstagefright_soft_ffmpegvdec \
    libFFmpegExtractor \
    libnamparser
