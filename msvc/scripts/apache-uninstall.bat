@ECHO OFF

REM This stops and uninstalls apache service

httpd -k stop -n "Apache EPIC CDB Web Server"
httpd -k uninstall -n "Apache EPIC CDB Web Server"

:ALL_DONE
