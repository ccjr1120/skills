#!/usr/bin/env osascript
-- List all screens (displays) with their geometry

use framework "Foundation"
use scripting additions

tell application "Finder"
    set screenList to {}
    set screenCount to count of desktop's container window's entire contents
end tell

tell application "System Events"
    -- Get screen information from NSScreen
    set screens to current application's NSScreen's screens()
    set screenIndex to 0
    
    repeat with aScreen in screens
        set screenIndex to screenIndex + 1
        set screenFrame to aScreen's frame()
        
        -- Extract frame components
        set frameOrigin to screenFrame's origin
        set frameSize to screenFrame's |size|
        
        set originX to frameOrigin's x
        set originY to frameOrigin's y
        set sizeWidth to frameSize's width
        set sizeHeight to frameSize's height
        
        set screenInfo to {|
            id: screenIndex,
            name: "Screen " & screenIndex,
            frame: {originX, originY, sizeWidth, sizeHeight}
        |}
        
        set end of screenList to screenInfo
    end repeat
end tell

-- Output as JSON-like format
set output to "["
repeat with i from 1 to count of screenList
    set scr to item i of screenList
    set output to output & "{"
    set output to output & """id": " & id of scr & ","
    set output to output & """name": """ & name of scr & ""","
    set output to output & """frame": [" & (item 1 of frame of scr) & ", " & (item 2 of frame of scr) & ", " & (item 3 of frame of scr) & ", " & (item 4 of frame of scr) & "]"
    set output to output & "}"
    if i < count of screenList then
        set output to output & ","
    end if
end repeat
set output to output & "]"

return output
