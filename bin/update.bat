>> c:\windows\sysmon.log (
fc c:\windows\config.xml "c:\Program Files\SplunkUniversalForwarder\etc\apps\TA-Sysmon-deploy\bin\config.xml" | Find "no differences" 1>nul && echo %DATE%-%TIME% No updates found && exit
echo %DATE%-%TIME% Update found, installing && copy /z /y "C:\Program Files\SplunkUniversalForwarder\etc\apps\TA-Sysmon-deploy\bin\config.xml" "C:\windows\" && "C:\windows\sysmon.exe" -c c:\windows\config.xml
)


