#!/usr/bin/env osascript
-- Move a window to a specific screen
-- Usage: move_window.scpt <window_id> <screen_number>
-- window_id format: "AppName:WindowTitle"

on run argv
    if count of argv < 2 then
        return "Error: Usage: move_window.scpt <window_id> <screen_number>"
    end if
    
    set windowID to item 1 of argv
    set screenNum to item 2 of argv as integer
    
    -- Parse window ID (format: "AppName:WindowTitle")
    set AppleScript's text item delimiters to ":"
    set textItems to text items of windowID
    set AppleScript's text item delimiters to ""
    
    if count of textItems < 2 then
        return "Error: Invalid window_id format. Expected 'AppName:WindowTitle'"
    end if
    
    set appName to item 1 of textItems
    set winTitle to item 2 of textItems
    
    -- Get target screen geometry
    tell application "System Events"
        set screens to current application's NSScreen's screens()
        if screenNum > count of screens or screenNum < 1 then
            return "Error: Invalid screen number " & screenNum & ". Available screens: 1-" & (count of screens)
        end if
        
        set targetScreen to item screenNum of screens
        set screenFrame to targetScreen's visibleFrame()
        
        set frameOrigin to screenFrame's origin
        set frameSize to screenFrame's |size|
        
        set originX to frameOrigin's x as integer
        set originY to frameOrigin's y as integer
        set sizeWidth to frameSize's width as integer
        set sizeHeight to frameSize's height as integer
    end tell
    
    -- Find and move the window
    tell application "System Events"
        try
            set targetApp to application process appName
            set targetWindow to window winTitle of targetApp
            
            -- Move window to target screen (top-left corner of target screen)
            set position of targetWindow to {originX, originY}
            
            return "Success: Moved window '" & winTitle & "' of " & appName & " to screen " & screenNum
        on error errMsg
            return "Error: Could not move window. " & errMsg
        end try
    end tell
end run
