<#PSScriptInfo

.VERSION 1.0

.GUID 31c7dfa4-b9ac-438d-a417-9763e56b6d10

.AUTHOR Michael Niehaus

.COMPANYNAME 

.COPYRIGHT

.TAGS OOBE Prompt

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
Prompt the user for information.
.DESCRIPTION
This is a super-simple script, feel free to enhance it as needed.  It is designed to be run by ServiceUI, started by
a Win32 app.  It can then show a UI that will appear in OOBE.
.EXAMPLE
.\OOBEPrompt.ps1
#>

[CmdletBinding()]
Param(
)

Process {

    # Start logging
    Start-Transcript "$($env:ProgramData)\OOBEPrompt\OOBEPrompt.log"

    # Run ShiftF10.exe so that we can be in the foreground
    & .\ShiftF10.exe | Out-Null

    # Prompt for information
    Add-Type -AssemblyName Microsoft.VisualBasic
    $computerName = [Microsoft.VisualBasic.Interaction]::InputBox('Specify the new computer name to assign:', 'Computer name', $env:COMPUTERNAME)

    Write-Host "Computer name specified: $computerName"
    if ($computerName -ne $env:COMPUTERNAME) {
        Rename-Computer -NewName $computerName -Force
        Write-Host "Renamed computer from $($env:COMPUTERNAME) to $computerName"
    } else {
        Write-Host "No new name specified, keeping existing name."
    }
}
