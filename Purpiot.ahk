; Purpiot - Null Movement and Rapid Trigger Script for AutoHotkey v2
; This script combines two features:
; 1. Null Movement: Prevents opposite directional keys (A/D and W/S) from being held simultaneously.
; 2. Rapid Trigger: Adds a rapid-fire function to the 'X' key.

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

global a_held := 0
global d_held := 0
global a_scrip := 0
global d_scrip := 0

global w_held := 0
global s_held := 0
global w_scrip := 0
global s_scrip := 0

; Scan Code Mappings:
; W   SC011
; A   SC01E
; S   SC01F
; D   SC020

*$SC01E::
{
    global

    a_held := 1
    
    if d_scrip
    {
        d_scrip := 0
        SendInput "{Blind}{SC020 up}"
    }
    
    a_scrip := 1
    SendInput "{Blind}{SC01E down}"
}

*$SC01E up::
{
    global

    a_held := 0
    
    if a_scrip
    {
        a_scrip := 0
        SendInput "{Blind}{SC01E up}"
    }
        
    if d_held && !d_scrip
    {
        d_scrip := 1
        SendInput "{Blind}{SC020 down}"
    }
}

*$SC020::
{
    global

    d_held := 1
    
    if a_scrip
    {
        a_scrip := 0
        SendInput "{Blind}{SC01E up}"
    }
    
    d_scrip := 1
    SendInput "{Blind}{SC020 down}"
}

*$SC020 up::
{
    global

    d_held := 0
    
    if d_scrip
    {
        d_scrip := 0
        SendInput "{Blind}{SC020 up}"
    }
    
    if a_held && !a_scrip
    {
        a_scrip := 1
        SendInput "{Blind}{SC01E down}"
    }
}

*$SC011::
{
    global

    w_held := 1

    if s_scrip 
    {
        s_scrip := 0
        SendInput "{Blind}{SC01F up}"
    }

    w_scrip := 1
    SendInput "{Blind}{SC011 down}"
}

*$SC011 up::
{
    global

    w_held := 0

    if w_scrip
    {
        w_scrip := 0
        SendInput "{Blind}{SC011 up}"
    }

    if s_held && !s_scrip 
    {
        s_scrip := 1
        SendInput "{Blind}{SC01F down}"
    }
}

*$SC01F::
{
    global

    s_held := 1

    if w_scrip 
    {
        w_scrip := 0
        SendInput "{Blind}{SC011 up}"
    }

    s_scrip := 1
    SendInput "{Blind}{SC01F down}"
}

*$SC01F up::
{
    global

    s_held := 0

    if s_scrip 
    {
        s_scrip := 0
        SendInput "{Blind}{SC01F up}"
    }

    if w_held && !w_scrip 
    {
        w_scrip := 1
        SendInput "{Blind}{SC011 down}"
    }
}

; ---
; Rapid Trigger Section
; ---
; When the X key is pressed down, a timer is started to repeatedly send a key press.
; The number '10' is the delay in milliseconds between key presses. Adjust this number to change the speed (smaller number = faster).

X::
{
    SetTimer () => SendInput("{Blind}{x}"), 10
}

; When the X key is released, the timer is stopped.
X Up::
{
    SetTimer () => SendInput("{Blind}{x}"), 0
}