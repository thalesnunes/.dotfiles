#!/usr/bin/env bash

# Helper function to handle the selection
handle_selection() {
    local action="$1"
    local id="$ROFI_INFO"

    # If ROFI_INFO is empty (some rofi versions), fallback to parsing the selection
    if [[ -z "$id" ]]; then
        id=$(echo "$@" | awk '{print $1}')
    fi

    if [[ -n "$id" ]]; then
        case "$action" in
            copy)
                # We only need the ID for decode to work
                printf "%s" "$id" | cliphist decode | wl-copy
                ;;
            delete)
                printf "%s" "$id" | cliphist delete
                ;;
        esac
    fi
}

# The performance engine
# We use a more robust awk to separate the ID from the content
print_list() {
    cliphist list | awk '
    {
        id = $1;          # The first "word" is the ID
        $1 = "";          # Remove the ID from the current line
        content = $0;     # The rest is the content
        sub(/^[ \t]+/, "", content); # Clean leading whitespace

        # Format: VisibleContent\0info\x1fID
        if (length(content) > 0) {
            printf "%s\0info\x1f%s\n", content, id
        }
    }'
}

case "$ROFI_RETV" in
    0)  # Initial execution
        echo -en "\0use-hot-keys\x1ftrue\n"
        print_list
        ;;
    1)  # Selected entry with Enter
        handle_selection "copy" "$@"
        ;;
    10) # Deleted entry with Control+d
        handle_selection "delete" "$@"
        print_list # Refresh list after delete
        ;;
esac
