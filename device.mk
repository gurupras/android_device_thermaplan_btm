ifeq ($(BOARD_HAS_THERMAPLAN),true)
$(warning "Building thermaplan")

PRODUCT_PROPERTY_OVERRIDES += \
    sys.thermaplan.enabled=1

BOARD_SEPOLICY_DIRS += \
    device/thermaplan-btm/sepolicy

PRODUCT_COPY_FILES += \
    device/thermaplan-btm/init.thermaplan.rc:root/init.thermaplan.rc \
    device/thermaplan-btm/su_daemon:system/bin/su_daemon

ifeq ($(THERMAPLAN_DISABLE_CPR_REGULATOR),true)
    $(warning "Including initrc file to disable CPR regulator")
    PRODUCT_PROPERTY_OVERRIDES += \
        sys.thermaplan.cpr=1

#    PRODUCT_COPY_FILES += \
#        device/thermaplan-btm/init.thermaplan_cpr.rc:root/init.thermaplan_cpr.rc
endif

endif
