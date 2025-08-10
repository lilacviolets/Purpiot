; Purpiot - Null Movement + Max-Speed Rapid Trigger for AutoHotkey v2
; Null Movement: Prevents opposite movement keys being held together.
; Rapid Trigger: X key spams at max speed while still functioning normally.

#Requires AutoHotkey v2
#SingleInstance force
#MaxThreads 1
#MaxThreadsBuffer 1
Persistent true
ListLines False
KeyHistory 0
ProcessSetPriority "High"
A_MaxHotkeysPerInterval := 99000000
A_HotkeyInterval := 0

; --- Null Movement State ---
global a_held := 0, d_held := 0, a_scrip := 0, d_scrip := 0
global w_held := 0, s_held := 0, w_scrip := 0, s_scrip := 0

; --- A ---
*$SC01E::
{
    a_held := 1
    if d_scrip {
        d_scrip := 0
        SendInput "{Blind}{SC020 up}"
    }
    a_scrip := 1
    SendInput "{Blind}{SC01E down}"
}

*$SC01E up::
{
    a_held := 0
    if a_scrip {
        a_scrip := 0
        SendInput "{Blind}{SC01E up}"
    }
    if d_held && !d_scrip {
        d_scrip := 1
        SendInput "{Blind}{SC020 down}"
    }
}

; --- D ---
*$SC020::
{
    d_held := 1
    if a_scrip {
        a_scrip := 0
        SendInput "{Blind}{SC01E up}"
    }
    d_scrip := 1
    SendInput "{Blind}{SC020 down}"
}

*$SC020 up::
{
    d_held := 0
    if d_scrip {
        d_scrip := 0
        SendInput "{Blind}{SC020 up}"
    }
    if a_held && !a_scrip {
        a_scrip := 1
        SendInput "{Blind}{SC01E down}"
    }
}

; --- W ---
*$SC011::
{
    w_held := 1
    if s_scrip {
        s_scrip := 0
        SendInput "{Blind}{SC01F up}"
    }
    w_scrip := 1
    SendInput "{Blind}{SC011 down}"
}

*$SC011 up::
{
    w_held := 0
    if w_scrip {
        w_scrip := 0
        SendInput "{Blind}{SC011 up}"
    }
    if s_held && !s_scrip {
        s_scrip := 1
        SendInput "{Blind}{SC01F down}"
    }
}

; --- S ---
*$SC01F::
{
    s_held := 1
    if w_scrip {
        w_scrip := 0
        SendInput "{Blind}{SC011 up}"
    }
    s_scrip := 1
    SendInput "{Blind}{SC01F down}"
}

*$SC01F up::
{
    s_held := 0
    if s_scrip {
        s_scrip := 0
        SendInput "{Blind}{SC01F up}"
    }
    if w_held && !w_scrip {
        w_scrip := 1
        SendInput "{Blind}{SC011 down}"
    }
}

; -------------------
; Max-Speed Rapid Trigger (X key)
; -------------------
$*x::
{
    SendInput("{Blind}{x down}")
    SetTimer rapidFireX, 1 ; 1ms = fastest possible
}

$*x up::
{
    SetTimer rapidFireX, 0
    SendInput("{Blind}{x up}")
}

rapidFireX()
{
    SendInput("{Blind}{x}")
}
