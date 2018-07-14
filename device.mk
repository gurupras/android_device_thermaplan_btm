ifeq ($(BOARD_HAS_THERMAPLAN),true)
$(warning "Building thermaplan")

PRODUCT_PROPERTY_OVERRIDES += \
    sys.thermaplan.enabled=1

BOARD_SEPOLICY_DIRS += \
    $(LOCAL_PATH)/sepolicy

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.thermaplan.rc:root/init.thermaplan.rc \
    $(LOCAL_PATH)/su_daemon:system/bin/su_daemon

ifeq ($(THERMAPLAN_DISABLE_CPR_REGULATOR),true)
    $(warning "Including initrc file to disable CPR regulator")
    PRODUCT_PROPERTY_OVERRIDES += \
        sys.thermaplan.cpr=1

    PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/init.thermaplan_cpr.rc:root/init.thermaplan_cpr.rc
endif

endif
