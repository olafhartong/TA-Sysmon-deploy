FOR /F "delims=" %%i IN ('wmic service SplunkForwarder get Pathname ^| FINDSTR /m service') DO SET SPLUNKDPATH=%%i
SET SPLUNKPATH=%SPLUNKDPATH:~1,-28%

>> %WINDIR%\sysmon.log (
ECHO %DATE%-%TIME% The SplunkUniversalForwarder is installed at %SPLUNKPATH%
ECHO %DATE%-%TIME% Checking for Sysmon64

FOR /F "delims=" %%c IN ('sc query "Sysmon64" ^| FIND /c "RUNNING"') DO (
    SET CHECK_SYSMON_RUNNIG=%%c
)

IF "%CHECK_SYSMON_RUNNIG%" == "1" (
    ECHO %DATE%-%TIME% Sysmon64 found, checking version
    FOR /F "delims=" %%b IN ('c:\windows\Sysmon64.exe ^| FIND /c "System Monitor v11.10"') DO (
    SET CHECK_SYSMON_VERSION=%%b
    )
    IF "%CHECK_SYSMON_VERSION%" == "1" (
        ECHO %DATE%-%TIME% Sysmon64 already up to date, exiting
        EXIT
    ) ELSE (
        ECHO %DATE%-%TIME% Sysmon64 binary is outdated, un-installing
        IF EXIST %WINDIR%\Sysmon64.exe (
            %WINDIR%\Sysmon64.exe -u
        )
    )
) ELSE (
    ECHO %DATE%-%TIME% Sysmon64 not found, proceding to install
    ECHO %DATE%-%TIME% Copying the latest config file
    COPY /z /y "%SPLUNKPATH%\etc\apps\TA-Sysmon-deploy\bin\config.xml" "C:\windows\"
    ECHO %DATE%-%TIME% Installing Sysmon64
    "%SPLUNKPATH%\etc\apps\TA-Sysmon-deploy\bin\.\Sysmon64.exe" -i c:\windows\config.xml -accepteula -h md5,sha256 -n -l | Find /c "Sysmon64 installed" 1>NUL
    ECHO %DATE%-%TIME% Install complete!
    EXIT
)
ECHO %DATE%-%TIME% Install failed
)
