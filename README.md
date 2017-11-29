# TA-Sysmon-deploy
Deploy Symon through the Splunk Deployment Server

Note! 
---
Currently it assumes the Universal Forwarder to be installed to C:\Program Files\SplunkUniversalForwarder and the app to be named TA-Sysmon-deploy

The included sysmon.exe is version 6.20, please replace with your own should you be wary of my file (MD5 (bin/sysmon.exe) = 8440937059359cda0ea357e9e4088e60)

The included config is a hardly modified version of @swiftonsecurity's configuration for demonstration purposes, you can start from this.

Usage:
---
Download and install to your deployment server under '/etc/deployment-apps' and assign to your servers

When deployed it will check for Sysmon on the system, when it is below the configured version (currently 6.20), it will uninstall that version and install 6.20 with the attached configuration

Every 12 hours it will check if the config file from the deployment server is newer than the running config. If so, it will update.

All actions of the scripts are logged and indexed into the Windows index as sourcetype InstallLog:Sysmon
