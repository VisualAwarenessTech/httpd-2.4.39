@ECHO OFF

REM This installs and starts the apache service 

httpd -k install -n "Apache EPIC CDB Web Server"
net start "Apache EPIC CDB Web Server"

:ALL_DONE
