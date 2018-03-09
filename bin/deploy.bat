echo off
FOR /F "delims=" %%i IN ('wmic service SplunkForwarder get Pathname ^| findstr /m service') DO set SPLUNKDPATH=%%i
set SPLUNKPATH=%SPLUNKDPATH:~1,-28%

>> c:\windows\sysmon.log (
echo %DATE%-%TIME% The SplunkUniversalForwarder is installed at %SPLUNKPATH%
echo %DATE%-%TIME% Checking for Sysmon
sc query "Sysmon" | Find /c "RUNNING" 2>nul && echo %DATE%-%TIME% Sysmon found, checking version && c:\windows\sysmon.exe | Find /c "System Monitor v7.01" 1>nul && echo %DATE%-%TIME% Sysmon already up to date, exiting && exit

sc query "Sysmon" | Find /c "RUNNING" 1>nul && c:\windows\sysmon.exe | Find /c "System Monitor v7.01" >nul || echo %DATE%-%TIME% Sysmon binary is outdated, un-installing && c:\windows\sysmon -u

echo %DATE%-%TIME% Sysmon not found, proceding to install
echo %DATE%-%TIME% Copying the latest config file && copy /z /y "%SPLUNKPATH%\etc\apps\TA-Sysmon-deploy\bin\config.xml" "C:\windows\" 
echo %DATE%-%TIME% Installing Sysmon && "%SPLUNKPATH%\etc\apps\TA-Sysmon-deploy\bin\sysmon.exe" /accepteula -i c:\windows\config.xml | Find /c "sysmon installed" 1>nul && echo %DATE%-%TIME% Install complete! && exit

echo %DATE%-%TIME% Install failed
)
