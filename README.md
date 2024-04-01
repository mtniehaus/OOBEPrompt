# OOBEPrompt

This repo includes a sample "app" that can be deployed via Intune that will prompt for information 
during the Autopilot device ESP process (inside OOBE).

The implementation isn't particularly useful: It prompts for a modified computer name, and if you change
the value from what was automatically assigned by Autopilot it will change the computer name to that 
value.  (This won't take effect until the next reboot, so you might want to add a line to the "OOBEPrompt.ps1"
script to "exit 3010" to cause a reboot at the end of device ESP.  Note that Azure AD and Intune may
continue to show the old computer name for a period of time, but they will eventually notice the
name change.)
