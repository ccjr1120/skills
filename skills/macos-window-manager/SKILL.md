---
name: macos-window-manager
description: macOS multi-screen window management with custom aliases. Use when user wants to (1) list all visible windows across displays, (2) list all connected screens/monitors, (3) move windows between screens by ID or alias, (4) create custom names/aliases for windows and screens. Supports commands like "move window 1 to screen 2" or "move Chrome to副屏" with user-defined aliases.
---

# macOS Window Manager

Intelligent window management for multi-screen macOS setups with custom naming support.

## Features

- List all visible windows with unique IDs
- List all connected screens with their geometry
- Move windows to specific screens
- Create custom aliases for windows and screens
- Natural language commands support

## Quick Start

### 1. List Windows

```bash
osascript scripts/list_windows.scpt
```

Returns JSON array of windows:
```json
[
  {"id": "Chrome:New Tab", "app": "Chrome", "title": "New Tab", "position": [100, 100], "size": [1200, 800]},
  {"id": "Code:project.js", "app": "Code", "title": "project.js", "position": [1300, 100], "size": [1000, 600]}
]
```

### 2. List Screens

```bash
osascript scripts/list_screens.scpt
```

Returns JSON array of screens:
```json
[
  {"id": 1, "name": "Screen 1", "frame": [0, 0, 1920, 1080]},
  {"id": 2, "name": "Screen 2", "frame": [1920, 0, 1920, 1080]}
]
```

### 3. Move Window to Screen

```bash
osascript scripts/move_window.scpt "Chrome:New Tab" 2
```

### 4. Manage Aliases

**Set aliases:**
```bash
# Name a window
./scripts/alias_manager.sh set-window chrome "Chrome:New Tab"

# Name a screen
./scripts/alias_manager.sh set-screen 副屏 2
```

**List aliases:**
```bash
./scripts/alias_manager.sh list
```

**Use aliases to move:**
```bash
osascript scripts/move_window.scpt $(./scripts/alias_manager.sh get-window chrome) $(./scripts/alias_manager.sh get-screen 副屏)
```

## Natural Language Commands

When user says things like:
- "把 Chrome 移到副屏" → Move Chrome window to screen alias "副屏"
- "把 1 号窗口移到 2 号屏幕" → Move first window to screen 2
- "列出所有窗口" → List windows
- "列出所有屏幕" → List screens

## Configuration

Aliases are stored in `~/.config/macos-window-manager/aliases.json`:

```json
{
  "windows": {
    "chrome": "Chrome:New Tab",
    "code": "Code:project.js"
  },
  "screens": {
    "主屏": "1",
    "副屏": "2",
    "竖屏": "3"
  }
}
```

## Scripts Reference

| Script | Purpose |
|--------|---------|
| `list_windows.scpt` | List all visible windows |
| `list_screens.scpt` | List all connected screens |
| `move_window.scpt` | Move window to screen |
| `alias_manager.sh` | Manage window/screen aliases |

## Requirements

- macOS 10.14+
- Accessibility permissions for System Events
- Python 3 (for alias manager)

## Troubleshooting

**"Error: Could not move window"**
- Ensure the target application has accessibility permissions
- Check that window ID format is correct: `AppName:WindowTitle`

**Window not appearing in list**
- Some system windows may not be accessible
- Minimized windows may not appear
