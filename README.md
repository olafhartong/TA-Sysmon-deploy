# TA-Sysmon-deploy
Deploy and maintain Symon through the Splunk Deployment Server.

This will enable you to have all systems running the same version of Sysmon and the same up-to-date configuration.
No more logging in to all servers and installing it manually or having to negotiate a GPO change.

When deployed it will check for Sysmon on the system, when it is below the configured version (currently 6.20), it will uninstall that version and install `6.20` with the attached configuration.

Every 12 hours it will check if the config file from the deployment server is newer than the running config. If so, it will update.
All actions of the scripts are logged and indexed into the Windows index as sourcetype InstallLog:Sysmon

Note! 
---
Currently it assumes the app to be named TA-Sysmon-deploy.

It will look for the SplunkForwarder service to be installed and use its install location as a variable in the script.

The included config is a hardly modified version of @swiftonsecurity's configuration for demonstration purposes, you can start from this.

Usage:
---
Obviously you are required to have a deployment server and installed Universal Forwarder agents connected to it.

Download the latest Sysmon version from here https://download.sysinternals.com/files/Sysmon.zip, due to the distribution license I am not able to include it. Place sysmon.exe in the bin folder and you're ready to deploy!

Download and install to your deployment server under `etc/deployment-apps` and assign to your servers.
