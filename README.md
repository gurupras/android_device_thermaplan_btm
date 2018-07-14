# Add thermaplan support to LineageOS builds

## Steps
First head to `device/<manufacturer>/<product>`.

Add the following line to `lineage.mk`
```
BOARD_HAS_THERMAPLAN := true
$(call inherit-product, device/thermaplan/device.mk)
```

You can also add additional settings such as `THERMAPLAN_DISABLE_CPR_REGULATOR` here.

Lastly, open the `init.<product>.rc` file and add `import init.thermaplan.rc` in the import section at the top of this file.
