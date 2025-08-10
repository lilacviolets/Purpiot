; ================================================================
; Purpiot - Null Movement + Always-On Rapid Trigger (AHK v1)
; ================================================================

#SingleInstance force
#Persistent
#MaxThreads 1
#MaxThreadsBuffer 1
ListLines Off
SetBatchLines, -1
Process, Priority,, High

; -------------------
; Null Movement State
; -------------------
global a_held := 0, d_held := 0, a_scrip := 0, d_scrip := 0
global w_held := 0, s_held := 0, w_scrip := 0, s_scrip := 0

; --- A ---
*$SC01E::
    a_held := 1
    if (d_scrip) {
        d_scrip := 0
        SendInput {Blind}{SC020 up}
    }
    a_scrip := 1
    SendInput {Blind}{SC01E down}
return

*$SC01E up::
    a_held := 0
    if (a_scrip) {
        a_scrip := 0
        SendInput {Blind}{SC01E up}
    }
    if (d_held && !d_scrip) {
        d_scrip := 1
        SendInput {Blind}{SC020 down}
    }
return

; --- D ---
*$SC020::
    d_held := 1
    if (a_scrip) {
        a_scrip := 0
        SendInput {Blind}{SC01E up}
    }
    d_scrip := 1
    SendInput {Blind}{SC020 down}
return

*$SC020 up::
    d_held := 0
    if (d_scrip) {
        d_scrip := 0
        SendInput {Blind}{SC020 up}
    }
    if (a_held && !a_scrip) {
        a_scrip := 1
        SendInput {Blind}{SC01E down}
    }
return

; --- W ---
*$SC011::
    w_held := 1
    if (s_scrip) {
        s_scrip := 0
        SendInput {Blind}{SC01F up}
    }
    w_scrip := 1
    SendInput {Blind}{SC011 down}
return

*$SC011 up::
    w_held := 0
    if (w_scrip) {
        w_scrip := 0
        SendInput {Blind}{SC011 up}
    }
    if (s_held && !s_scrip) {
        s_scrip := 1
        SendInput {Blind}{SC01F down}
    }
return

; --- S ---
*$SC01F::
    s_held := 1
    if (w_scrip) {
        w_scrip := 0
        SendInput {Blind}{SC011 up}
    }
    s_scrip := 1
    SendInput {Blind}{SC01F down}
return

*$SC01F up::
    s_held := 0
    if (s_scrip) {
        s_scrip := 0
        SendInput {Blind}{SC01F up}
    }
    if (w_held && !w_scrip) {
        w_scrip := 1
        SendInput {Blind}{SC011 down}
    }
return

; -------------------
; Always-On Rapid Trigger for X
; -------------------
$*x::
    Loop
    {
        if !GetKeyState("x", "P")
            break
        SendInput {Blind}{x down}{x up}
        Sleep 10 ; ~100 presses/sec, lower = faster
    }
return

; -------------------
; Emergency Key Release
; -------------------
^Esc::
    SendInput {Blind}{SC01E up}{SC020 up}{SC011 up}{SC01F up}{x up}
    a_held := d_held := w_held := s_held := 0
    a_scrip := d_scrip := w_scrip := s_scrip := 0
return
