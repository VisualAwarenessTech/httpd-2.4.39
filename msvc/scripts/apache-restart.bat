@ECHO OFF

REM This restarts the apache service 

httpd -k restart -n "Apache EPIC CDB Web Server"

:ALL_DONE
