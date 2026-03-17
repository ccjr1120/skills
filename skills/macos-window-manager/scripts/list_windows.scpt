#!/usr/bin/env osascript
-- List all visible windows with their IDs and titles

use framework "Foundation"
use scripting additions

set windowList to {}

tell application "System Events"
    set allProcesses to application processes whose background only is false
    repeat with proc in allProcesses
        set procName to name of proc
        try
            set procWindows to windows of proc
            repeat with win in procWindows
                try
                    set winTitle to name of win
                    set winPos to position of win
                    set winSize to size of win
                    
                    -- Create unique ID based on process and window
                    set winID to procName & ":" & winTitle
                    
                    set winInfo to {|
                        id: winID,
                        app: procName,
                        title: winTitle,
                        position: winPos,
                        size: winSize
                    |}
                    
                    set end of windowList to winInfo
                on error
                    -- Skip windows that can't be accessed
                end try
            end repeat
        on error
            -- Skip processes that can't be accessed
        end try
    end repeat
end tell

-- Output as JSON-like format
set output to "["
repeat with i from 1 to count of windowList
    set win to item i of windowList
    set output to output & "{"
    set output to output & """id": """ & id of win & ""","
    set output to output & """app": """ & app of win & ""","
    set output to output & """title": """ & title of win & ""","
    set output to output & """position": [" & (item 1 of position of win) & ", " & (item 2 of position of win) & "],"
    set output to output & """size": [" & (item 1 of size of win) & ", " & (item 2 of size of win) & "]"
    set output to output & "}"
    if i < count of windowList then
        set output to output & ","
    end if
end repeat
set output to output & "]"

return output
