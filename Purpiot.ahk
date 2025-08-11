#Requires AutoHotkey v2
#SingleInstance Force

OnStartup() {
    banner := """
|'|       '    |    |   
|||/~~|/~~\  /|/~\|/~/~|~(~
|||\__|\__ \/ |\_/|\/_ | _)
                                
Null Movement Script - Purpiot v1.0
https://github.com/lilacviolets/Purpiot
"""
    MsgBox(banner, "Purpiot Script Loaded")
}
OnStartup()

; --- Global State Variables ---
; Stores the last-pressed key for each axis.
global last_x_key := ""
global last_y_key := ""

; --- Hotkey Definitions ---
; Use a single hotkey to capture all key events (down and up).
; The 'Up' directive handles both key-down and key-up events.
; The '*' prefix allows the hotkey to fire regardless of other modifiers (Shift, Ctrl, etc.).
; The 'Up' suffix is a v2-specific feature to handle key-up events.

; A / D axis (Left / Right)
*a:: HandleMovement("x", "a", "d")
*d:: HandleMovement("x", "d", "a")
*a Up:: HandleMovementUp("x", "a", "d")
*d Up:: HandleMovementUp("x", "d", "a")

; W / S axis (Forward / Backward)
*w:: HandleMovement("y", "w", "s")
*s:: HandleMovement("y", "s", "w")
*w Up:: HandleMovementUp("y", "w", "s")
*s Up:: HandleMovementUp("y", "s", "w")

; --- Movement Functions ---
HandleMovement(axis, currentKey, opposingKey) {
    global last_x_key, last_y_key

    ; Determine which global variable to update
    current_last_key := (axis == "x") ? last_x_key : last_y_key
    
    ; If the opposing key is currently pressed, release it
    if GetKeyState(opposingKey, "P") {
        if (current_last_key != currentKey) {
            SendInput "{Blind}{" opposingKey " Up}"
        }
    }
    
    ; Press the current key if it wasn't the last one we pressed
    if (current_last_key != currentKey) {
        SendInput "{Blind}{" currentKey " Down}"
    }

    ; Update the last pressed key for this axis
    if (axis == "x") {
        last_x_key := currentKey
    } else {
        last_y_key := currentKey
    }
}

HandleMovementUp(axis, currentKey, opposingKey) {
    global last_x_key, last_y_key

    ; Determine which global variable to check
    current_last_key := (axis == "x") ? last_x_key : last_y_key

    ; If the key being released was the last one pressed...
    if (current_last_key == currentKey) {
        SendInput "{Blind}{" currentKey " Up}"
        
        ; If the opposing key is still held, press it
        if GetKeyState(opposingKey, "P") {
            SendInput "{Blind}{" opposingKey " Down}"
            
            ; Update the last pressed key for this axis
            if (axis == "x") {
                last_x_key := opposingKey
            } else {
                last_y_key := opposingKey
            }
        }
    }
}
