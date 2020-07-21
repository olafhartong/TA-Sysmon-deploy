ECHO OFF

FOR /F "delims=" %%i IN ('wmic service SplunkForwarder get Pathname ^| FINDSTR /m service') DO SET SPLUNKDPATH=%%i
SET SPLUNKPATH=%SPLUNKDPATH:~1,-28%

>> %WINDIR%\sysmon.log (
ECHO %DATE%-%TIME% The SplunkUniversalForwarder is installed at %SPLUNKPATH%
ECHO %DATE%-%TIME% Checking for Sysmon

FOR /F "delims=" %%c IN ('sc query "Sysmon" ^| FIND /c "RUNNING"') DO (
    SET CHECK_SYSMON_RUNNIG=%%c
)

FOR /F "delims=" %%b IN ('c:\windows\sysmon.exe ^| FIND /c "System Monitor v11.10"') DO (
    SET CHECK_SYSMON_VERSION=%%b
)

if "%CHECK_SYSMON_RUNNIG%" == "1" (
    ECHO %DATE%-%TIME% Sysmon found, checking version
    IF "%CHECK_SYSMON_VERSION%" == "1" (
        ECHO %DATE%-%TIME% Sysmon already up to date, exiting
        EXIT
    ) ELSE (
        ECHO %DATE%-%TIME% Sysmon binary is outdated, un-installing
        IF EXIST %WINDIR%\sysmon.exe (
            %WINDIR%\sysmon.exe -u
        )
    )
) ELSE (
    ECHO %DATE%-%TIME% Sysmon not found, proceding to install
    ECHO %DATE%-%TIME% Copying the latest config file
    COPY /z /y "%SPLUNKPATH%\etc\apps\TA-Sysmon-deploy\bin\config.xml" "C:\windows\"
    ECHO %DATE%-%TIME% Installing Sysmon
    "%SPLUNKPATH%\etc\apps\TA-Sysmon-deploy\bin\sysmon.exe" /accepteula -i c:\windows\config.xml | Find /c "Sysmon installed" 1>NUL
    ECHO %DATE%-%TIME% Install complete!
    EXIT
)
ECHO %DATE%-%TIME% Install failed
)
