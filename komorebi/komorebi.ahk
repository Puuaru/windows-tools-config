#SingleInstance Force

; Notify
TrayTip, komorebi.ahk, Starting komorebi, , 1

; Reload script
; ^#!r::Reload

; Start komorebi
RunWait, komorebic.exe start --await-configuration, , Hide

; Use generated configuration
#Include %A_ScriptDir%\komorebic.lib.ahk
#Include %A_ScriptDir%\komorebi.generated.ahk

; Default to minimizing windows when switching workspaces
WindowHidingBehaviour("minimize")

; Enable focus follows mouse
ToggleFocusFollowsMouse("windows")

; Set cross-monitor move behaviour to insert instead of swap
CrossMonitorMoveBehaviour("insert")

; Enable hot reloading of changes to this file
WatchConfiguration("enable")

; Ensure there are 10 workspaces created on monitor 0, and 1 on monitor 1
EnsureWorkspaces(0, 4)
EnsureWorkspaces(1, 1)

RunWait, komorebic.exe workspace-name 0 0 main, , Hide
RunWait, komorebic.exe workspace-name 0 1 terminal, , Hide
RunWait, komorebic.exe workspace-name 0 2 music, , Hide
RunWait, komorebic.exe workspace-name 0 3 entertainment, , Hide

; Configure the invisible border dimensions
InvisibleBorders(7, 0, 14, 7)
ActiveWindowBorder("disable")

; Allow komorebi to start managing windows
CompleteConfiguration()

; Open Yasb
Run, python D:\CustomApp\yasb\src\main.py, , Hide

Loop, 4 {
    ContainerPadding(0, A_Index - 1, 4)
    WorkspacePadding(0, A_Index - 1, 6)
}

ContainerPadding(1, 0, 4)
WorkspacePadding(1, 0, 6)

; Notify
TrayTip, komorebi.ahk, komorebi Started, , 1

; Change the focused window, Alt + Vim direction keys (HJKL)
!h::
    Focus("left")
return

!j::
    Focus("down")
return

!k::
    Focus("up")
return

!l::
    Focus("right")
return

; Move the focused window in a given direction, Alt + Shift + Vim direction keys (HJKL)
!+h::
    Move("left")
return

!+j::
    Move("down")
return

!+k::
    Move("up")
return

!+l::
    Move("right")
return

; Workspace layouts
!v::
    ChangeLayout("vertical-stack")
return

!e::
    ChangeLayout("horizontal-stack")
return

#f::
    ToggleFloat()
return

; Switch between different workspaces
#1::
#2::
#3::
#4::
#5::
#6::
#7::
#8::
#9::
    WorkspaceNum := SubStr(A_ThisHotkey, 2) - 1
    FocusMonitorWorkspace(0, WorkspaceNum)
return
#0::
    ; Special case: 0 is secondary monitor
    FocusMonitorWorkspace(1, 0)
return

; Move windows between different workspaces
>!+1::
>!+2::
>!+3::
>!+4::
>!+5::
>!+6::
>!+7::
>!+8::
>!+9::
    WorkspaceNum := SubStr(A_ThisHotkey, 3) - 1
    MoveToMonitor(0)
    MoveToWorkspace(WorkspaceNum)
return
>!+0::
    ; Special case: 0 is secondary monitor
    MoveToMonitor(1)
    MoveToWorkspace(0)
return

; window utils

<#q::
    WinClose, A
return

<#Enter::
    Run, wt.exe
return
