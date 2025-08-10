; Purpiot - Null Movement Script for AutoHotkey v2
; Ensures only one opposing key of each pair (A/D and W/S) is held at a time.
; Holding both will cause movement in the direction of the last pressed key.

#Requires AutoHotkey v2
#SingleInstance force
#MaxThreads 1
#MaxThreadsBuffer 1

; --- ASCII Banner ---
; Displays once when script starts

OnStartup() {
    banner =
    (
    "
     ____                  _       _       
    |  __| _ __   ___  ___| |_ ___| |_ ___ 
    | |__ | '_ \ / _ \/ __| __/ _ \ __/ __|
    |  __|| |_) |  __/ (__| ||  __/ |_\__ \
    |_|   | .__/ \___|\___|\__\___|\__|___/
          |_|                              
    Null Movement Script - Purpiot v1.0
    https://github.com/yourrepo
    "
    )
    MsgBox banner, "Purpiot Script Loaded"
}
OnStartup()

; --- Performance Settings ---
Persistent := true
ListLines := false
KeyHistory := 0
ProcessSetPriority "High"
A_MaxHotkeysPerInterval := 99000000
A_HotkeyInterval := 0

; --- Global State Variables ---
global 
(
    a_held := 0    ; Actual physical state of A key
    d_held := 0    ; Actual physical state of D key
    a_scrip := 0   ; Script output state of A key (whether script is sending A down)
    d_scrip := 0   ; Script output state of D key

    w_held := 0    ; Actual physical state of W key
    s_held := 0    ; Actual physical state of S key
    w_scrip := 0   ; Script output state of W key
    s_scrip := 0   ; Script output state of S key
)

; --- Key Scan Codes ---
; W = SC011
; A = SC01E
; S = SC01F
; D = SC020

; -----------------------------------------
; SECTION 1: LEFT / RIGHT (A / D) Keys Logic
; -----------------------------------------

*$SC01E:: { ; A key down
    global
    a_held := 1
    if d_scrip {
        d_scrip := 0
        SendInput "{Blind}{SC020 up}"  ; Release D if currently held by script
    }
    a_scrip := 1
    SendInput "{Blind}{SC01E down}"
}

*$SC01E up:: { ; A key up
    global
    a_held := 0
    if a_scrip {
        a_scrip := 0
        SendInput "{Blind}{SC01E up}"
    }
    if d_held && !d_scrip {
        d_scrip := 1
        SendInput "{Blind}{SC020 down}" ; Press D if physically held
    }
}

*$SC020:: { ; D key down
    global
    d_held := 1
    if a_scrip {
        a_scrip := 0
        SendInput "{Blind}{SC01E up}"  ; Release A if currently held by script
    }
    d_scrip := 1
    SendInput "{Blind}{SC020 down}"
}

*$SC020 up:: { ; D key up
    global
    d_held := 0
    if d_scrip {
        d_scrip := 0
        SendInput "{Blind}{SC020 up}"
    }
    if a_held && !a_scrip {
        a_scrip := 1
        SendInput "{Blind}{SC01E down}" ; Press A if physically held
    }
}

; -----------------------------------------
; SECTION 2: FORWARD / BACK (W / S) Keys Logic
; -----------------------------------------

*$SC011:: { ; W key down
    global
    w_held := 1
    if s_scrip {
        s_scrip := 0
        SendInput "{Blind}{SC01F up}"  ; Release S if currently held by script
    }
    w_scrip := 1
    SendInput "{Blind}{SC011 down}"
}

*$SC011 up:: { ; W key up
    global
    w_held := 0
    if w_scrip {
        w_scrip := 0
        SendInput "{Blind}{SC011 up}"
    }
    if s_held && !s_scrip {
        s_scrip := 1
        SendInput "{Blind}{SC01F down}" ; Press S if physically held
    }
}

*$SC01F:: { ; S key down
    global
    s_held := 1
    if w_scrip {
        w_scrip := 0
        SendInput "{Blind}{SC011 up}"  ; Release W if currently held by script
    }
    s_scrip := 1
    SendInput "{Blind}{SC01F down}"
}

*$SC01F up:: { ; S key up
    global
    s_held := 0
    if s_scrip {
        s_scrip := 0
        SendInput "{Blind}{SC01F up}"
    }
    if w_held && !w_scrip {
        w_scrip := 1
        SendInput "{Blind}{SC011 down}" ; Press W if physically held
    }
}
