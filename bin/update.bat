FOR /F "delims=" %%i IN ('wmic service SplunkForwarder get Pathname ^| findstr /m service') DO set SPLUNKDPATH=%%i
set SPLUNKPATH=%SPLUNKDPATH:~1,-28%
>> c:\windows\sysmon.log (
fc c:\windows\config.xml "%SPLUNKPATH%\etc\apps\TA-Sysmon-deploy\bin\config.xml" | Find "no differences" 1>nul && echo %DATE%-%TIME% No updates found && exit
echo %DATE%-%TIME% Update found, installing && copy /z /y "%SPLUNKPATH%\etc\apps\TA-Sysmon-deploy\bin\config.xml" "C:\windows\" && "C:\windows\Sysmon64.exe" -c c:\windows\config.xml
)
