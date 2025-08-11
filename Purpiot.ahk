; Purpiot - Null Movement Script for AutoHotkey v2
; Ensures only one opposing key of each pair (A/D and W/S) is held at a time.
; Holding both causes movement in the direction of the last pressed key.

#Requires AutoHotkey v2
#SingleInstance force
#MaxThreads 1
#MaxThreadsBuffer 1

OnStartup() {
    banner :=
    (
    "
 ____                  _       _       
|  __| _ __   ___  ___| |_ ___| |_ ___ 
| |__ | '_ \ / _ \/ __| __/ _ \ __/ __|
|  __|| |_) |  __/ (__| ||  __/ |_\__ \
|_|   | .__/ \___|\___|\__\___|\__|___/
      |_|                              
Null Movement Script - Purpiot v1.0
https://github.com/lilacviolets/Purpiot
"
    )
    MsgBox banner, "Purpiot Script Loaded"
}
OnStartup()

; Performance tweaks
ProcessSetPriority("High")
A_MaxHotkeysPerInterval := 99000000
A_HotkeyInterval := 0

; Global key states
global
(
    a_held := 0, d_held := 0, a_scrip := 0, d_scrip := 0
    w_held := 0, s_held := 0, w_scrip := 0, s_scrip := 0
)

; Scan codes for keys
; W = SC011, A = SC01E, S = SC01F, D = SC020

; --- LEFT / RIGHT (A / D) ---

*$SC01E:: { ; A down
    global
    a_held := 1
    if d_scrip {
        d_scrip := 0
        SendInput("{Blind}{SC020 up}")
    }
    if !a_scrip {
        a_scrip := 1
        SendInput("{Blind}{SC01E down}")
    }
}

*$SC01E up:: { ; A up
    global
    a_held := 0
    if a_scrip {
        a_scrip := 0
        SendInput("{Blind}{SC01E up}")
    }
    if d_held && !d_scrip {
        d_scrip := 1
        SendInput("{Blind}{SC020 down}")
    }
}

*$SC020:: { ; D down
    global
    d_held := 1
    if a_scrip {
        a_scrip := 0
        SendInput("{Blind}{SC01E up}")
    }
    if !d_scrip {
        d_scrip := 1
        SendInput("{Blind}{SC020 down}")
    }
}

*$SC020 up:: { ; D up
    global
    d_held := 0
    if d_scrip {
        d_scrip := 0
        SendInput("{Blind}{SC020 up}")
    }
    if a_held && !a_scrip {
        a_scrip := 1
        SendInput("{Blind}{SC01E down}")
    }
}

; --- FORWARD / BACK (W / S) ---

*$SC011:: { ; W down
    global
    w_held := 1
    if s_scrip {
        s_scrip := 0
        SendInput("{Blind}{SC01F up}")
    }
    if !w_scrip {
        w_scrip := 1
        SendInput("{Blind}{SC011 down}")
    }
}

*$SC011 up:: { ; W up
    global
    w_held := 0
    if w_scrip {
        w_scrip := 0
        SendInput("{Blind}{SC011 up}")
    }
    if s_held && !s_scrip {
        s_scrip := 1
        SendInput("{Blind}{SC01F down}")
    }
}

*$SC01F:: { ; S down
    global
    s_held := 1
    if w_scrip {
        w_scrip := 0
        SendInput("{Blind}{SC011 up}")
    }
    if !s_scrip {
        s_scrip := 1
        SendInput("{Blind}{SC01F down}")
    }
}

*$SC01F up:: { ; S up
    global
    s_held := 0
    if s_scrip {
        s_scrip := 0
        SendInput("{Blind}{SC01F up}")
    }
    if w_held && !w_scrip {
        w_scrip := 1
        SendInput("{Blind}{SC011 down}")
    }
}
