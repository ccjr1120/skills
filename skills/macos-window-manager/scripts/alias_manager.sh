#!/bin/bash
# Window and Screen alias manager
# Usage: alias_manager.sh [list|set-window|set-screen|remove-window|remove-screen|get-window|get-screen]

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/aliases.json"

# Initialize config if not exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo '{"windows": {}, "screens": {}}' > "$CONFIG_FILE"
fi

list_aliases() {
    echo "=== Window Aliases ==="
    cat "$CONFIG_FILE" | python3 -c "import sys,json; d=json.load(sys.stdin)['windows']; [print(f'  {k}: {v}') for k,v in d.items()]" 2>/dev/null || echo "  (none)"
    echo ""
    echo "=== Screen Aliases ==="
    cat "$CONFIG_FILE" | python3 -c "import sys,json; d=json.load(sys.stdin)['screens']; [print(f'  {k}: {v}') for k,v in d.items()]" 2>/dev/null || echo "  (none)"
}

set_window_alias() {
    local alias="$1"
    local window_id="$2"
    python3 -c "
import sys, json
with open('$CONFIG_FILE', 'r') as f:
    data = json.load(f)
data['windows']['$alias'] = '$window_id'
with open('$CONFIG_FILE', 'w') as f:
    json.dump(data, f, indent=2)
print(f'Set window alias: $alias -> $window_id')
"
}

set_screen_alias() {
    local alias="$1"
    local screen_num="$2"
    python3 -c "
import sys, json
with open('$CONFIG_FILE', 'r') as f:
    data = json.load(f)
data['screens']['$alias'] = '$screen_num'
with open('$CONFIG_FILE', 'w') as f:
    json.dump(data, f, indent=2)
print(f'Set screen alias: $alias -> Screen $screen_num')
"
}

get_window_alias() {
    local alias="$1"
    python3 -c "
import sys, json
with open('$CONFIG_FILE', 'r') as f:
    data = json.load(f)
print(data['windows'].get('$alias', '$alias'))
"
}

get_screen_alias() {
    local alias="$1"
    python3 -c "
import sys, json
with open('$CONFIG_FILE', 'r') as f:
    data = json.load(f)
print(data['screens'].get('$alias', '$alias'))
"
}

remove_window_alias() {
    local alias="$1"
    python3 -c "
import sys, json
with open('$CONFIG_FILE', 'r') as f:
    data = json.load(f)
if '$alias' in data['windows']:
    del data['windows']['$alias']
    with open('$CONFIG_FILE', 'w') as f:
        json.dump(data, f, indent=2)
    print(f'Removed window alias: $alias')
else:
    print(f'Alias not found: $alias')
"
}

remove_screen_alias() {
    local alias="$1"
    python3 -c "
import sys, json
with open('$CONFIG_FILE', 'r') as f:
    data = json.load(f)
if '$alias' in data['screens']:
    del data['screens']['$alias']
    with open('$CONFIG_FILE', 'w') as f:
        json.dump(data, f, indent=2)
    print(f'Removed screen alias: $alias')
else:
    print(f'Alias not found: $alias')
"
}

# Main
case "$1" in
    list)
        list_aliases
        ;;
    set-window)
        set_window_alias "$2" "$3"
        ;;
    set-screen)
        set_screen_alias "$2" "$3"
        ;;
    get-window)
        get_window_alias "$2"
        ;;
    get-screen)
        get_screen_alias "$2"
        ;;
    remove-window)
        remove_window_alias "$2"
        ;;
    remove-screen)
        remove_screen_alias "$2"
        ;;
    *)
        echo "Usage: $0 [list|set-window <alias> <window_id>|set-screen <alias> <screen_num>|get-window <alias>|get-screen <alias>|remove-window <alias>|remove-screen <alias>]"
        exit 1
        ;;
esac
