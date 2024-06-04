#NoEnv
SendMode Input
SetBatchLines -1

; Initialize variables
clickModifier := 20  ; Default click modifier value
clickEnhancerEnabled := true  ; Click enhancer initially enabled
hotkey := "F1"  ; Default hotkey

; Create the GUI
Gui, Add, Text,, Click Modifier:
Gui, Add, Edit, vClickModifier, %clickModifier%
Gui, Add, Text,, Hotkey (Changes take effect immediately):
Gui, Add, Edit, vNewHotkey, %hotkey%
Gui, Add, Button, gSetModifier, Set Modifier
Gui, Add, Button, gSetHotkey, Set Hotkey
Gui, Add, Button, gToggleClickEnhancer, % (clickEnhancerEnabled ? "Pause" : "Resume") " Click Enhancer"
Gui, Show, , Click Enhancer

; Left mouse button click
*LButton::
    if (clickEnhancerEnabled) {
        Click
        Loop, %clickModifier% {
            Click
        }
    } else {
        Send, {LButton}
        Send, {x}
        Send, {9}
    }
    return

; Right mouse button click
*RButton::
    if (clickEnhancerEnabled) {
        Loop, %clickModifier% {
            Click, Right
        }
    } else {
        Send, {RButton}
    }
    return

; Toggle click enhancer
ToggleClickEnhancer:
    clickEnhancerEnabled := !clickEnhancerEnabled
    GuiControl,, gToggleClickEnhancer, % (clickEnhancerEnabled ? "Pause" : "Resume") " Click Enhancer"
    return

; Set click modifier
SetModifier:
    Gui, Submit, NoHide
    clickModifier := ClickModifier
    return

; Set hotkey
SetHotkey:
    Gui, Submit, NoHide
    newHotkey := NewHotkey
    Hotkey, %hotkey%, ToggleClickEnhancer, Off  ; Disable the old hotkey
    Hotkey, %newHotkey%, ToggleClickEnhancer, On  ; Enable the new hotkey
    hotkey := newHotkey  ; Update the hotkey variable
    return

; Close the script
GuiClose:
ExitApp

; Pause/resume the script with the hotkey
Hotkey, IfWinActive, Click Enhancer
*F1::
    Suspend, Toggle
return
Hotkey, IfWinActive
