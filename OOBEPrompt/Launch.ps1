<#PSScriptInfo

.VERSION 1.0

.GUID 745db37a-cb0b-4644-900d-5401c7896946

.AUTHOR Michael Niehaus

.COMPANYNAME

.COPYRIGHT

.TAGS Launch

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES

Version 1.0:  Original published version.

#>

<#
.SYNOPSIS
Launches the specified PowerShell script in a new process running in the specified session.
.DESCRIPTION
This script uses ServiceUI.exe to start a new PowerShell session in the specified session ID.
.EXAMPLE
.\UpdateOS.ps1
#>

[CmdletBinding()]
Param(
    [Parameter(Mandatory = $False)] [string] $Script = "OOBEPrompt.ps1",
    [Parameter(Mandatory = $False)] [Int32] $SessionID = 1
)

Process {

    # Start logging
    if (-not (Test-Path "$($env:ProgramData)\OOBEPrompt")) {
        Mkdir "$($env:ProgramData)\OOBEPrompt"
    }
    Start-Transcript "$($env:ProgramData)\OOBEPrompt\Launch.log"

    # Since ServiceUI.exe is 64-bit, we want it to run the 64-bit PowerShell.exe, passing in the script path
    $psExe = "$($env:WINDIR)\System32\WindowsPowerShell\v1.0\powershell.exe"
    & .\ServiceUI.exe -session:$sessionID $psExe -ExecutionPolicy Bypass -NoProfile -File "$PSScriptRoot\$Script"

    # Create a tag file just so Intune knows this was installed
    Set-Content -Path "$($env:ProgramData)\OOBEPrompt\OOBEPrompt.ps1.tag" -Value "Installed"
    Stop-Transcript
}
