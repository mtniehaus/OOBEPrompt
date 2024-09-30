#Requires AutoHotkey v2.0

; First send the Shift-F10
WinActivate "Microsoft account"
Send "+{F10}"

; Wait for the command prompt and close it
WinWait "Administrator: C:\Windows\system32\cmd.exe"
pid := WinGetPID()
ProcessClose pid

; If the TSProgressUI window exists, bring it to the front
if WinExist("Installation Progress")
    WinActivate
