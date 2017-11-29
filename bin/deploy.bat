echo off
>> c:\windows\sysmon.log (
echo %DATE%-%TIME% Checking for Sysmon
sc query "Sysmon" | Find /c "RUNNING" 1>nul && echo %DATE%-%TIME% Sysmon found, checking version && c:\windows\sysmon.exe | Find /c "System Monitor v6.20" 1>nul && echo %DATE%-%TIME% Sysmon already up to date, exiting && exit
sc query "Sysmon" | Find /c "RUNNING" 1>nul && c:\windows\sysmon.exe | Find /c "System Monitor v6.20" >nul || echo %DATE%-%TIME% Sysmon binary is outdated, un-installing && c:\windows\sysmon -u
echo %DATE%-%TIME% Sysmon not found, proceding to install
echo %DATE%-%TIME% Copying the latest config file && copy /z /y "C:\Program Files\SplunkUniversalForwarder\etc\apps\TA-Sysmon-deploy\bin\config.xml" "C:\windows\" 
echo %DATE%-%TIME% Installing Sysmon && "C:\Program Files\SplunkUniversalForwarder\etc\apps\TA-Sysmon-deploy\bin\sysmon.exe" /accepteula -i c:\windows\config.xml | Find /c "sysmon installed" 1>nul && echo %DATE%-%TIME% Install complete! && exit
echo %DATE%-%TIME% Install failed
)
