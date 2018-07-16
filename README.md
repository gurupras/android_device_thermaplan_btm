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

###SELinux
Your compilation may fail due to SELinux inconsistencies. The Thermaplan testing apps (platform_app) requires permissions to create a unix socket under `/dev` which is not allowed on Treble devices. In this case, head to `system/sepolicy` and apply the following patch

```
diff --git a/private/app.te b/private/app.te
index c0deb08..c388cef 100644
--- a/private/app.te
+++ b/private/app.te
@@ -393,7 +393,7 @@ neverallow appdomain
 neverallow appdomain domain:netlink_kobject_uevent_socket { write append };

 # Sockets under /dev/socket that are not specifically typed.
-neverallow appdomain socket_device:sock_file write;
+neverallow { appdomain - system_app -platform_app } socket_device:sock_file write;

 # Unix domain sockets.
 neverallow appdomain adbd_socket:sock_file write;
diff --git a/public/domain.te b/public/domain.te
index 2cbe397..a55a0a6 100644
--- a/public/domain.te
+++ b/public/domain.te
@@ -658,6 +658,7 @@ full_treble_only(`
     -socket_between_core_and_vendor_violators
     -sudaemon
     -system_app
+    -platform_app
   } {
     file_type
     dev_type
```
