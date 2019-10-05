@ECHO OFF

IF exist "C:\EPIC_Ready" (echo "C:\EPIC_Ready ok") ELSE (mkdir "C:\EPIC_Ready" && icacls "C:\EPIC_Ready" /t /grant Everyone:F && echo "Created C:\EPIC_Ready")
IF exist "C:\EPIC_Ready\tmp" (echo "C:\EPIC_Ready\tmp ok") ELSE (mkdir "C:\EPIC_Ready\tmp" && icacls "C:\EPIC_Ready\tmp" /t /grant Everyone:F && echo "Created C:\EPIC_Ready\tmp")
IF exist "C:\EPIC_Ready\tmp\ms_tmp" (echo "C:\EPIC_Ready\tmp\ms_tmp ok") ELSE (mkdir "C:\EPIC_Ready\tmp\ms_tmp" && icacls "C:\EPIC_Ready\tmp\ms_tmp" /t /grant Everyone:F && echo "Created C:\EPIC_Ready\tmp\ms_tmp")
REM This installs and starts the apache service 

httpd -k install -n "Apache EPIC CDB Web Server"
net start "Apache EPIC CDB Web Server"

:ALL_DONE
