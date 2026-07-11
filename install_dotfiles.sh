#!/usr/bin/env bash

set -euo pipefail

source "$DOT/install_utils.sh"

is_installed "stow"
is_installed "awk"

if [ ! -d "$DOT" ]; then
    git clone https://github.com/thalesnunes/.dotfiles "$DOT"
fi

function solve_stow_conflicts() {
    local target="$1"
    conflicts=$(stow -nt "$target" */ 2>&1 | sed -n 's|.*over existing target \([^ ]*\).*|'"$target"'/\1|p')

    if [ -n "$conflicts" ]; then
        log "The following conflicts were found:"
        echo "$conflicts"

        rm_pr="Do you want to REMOVE all the conflicted files? [Y/n]: "
        mv_pr="Do you want to MOVE all the conflicted files to .old files? [Y/n]: "
        if yn_pr "$rm_pr"; then
            echo "$conflicts" | xargs rm -rf
            log "Removed conflicted files"
        elif yn_pr "$mv_pr"; then
            echo "$conflicts" | xargs mv {} {}.old
            log "Moved conflicted files to .old"
        else
            log_error "Can't stow with conflicting packages"
            return 1
        fi
    else
        log "No conflicts found in $target"
    fi
    return 0
}

function stow_packages() {

    source="$1"
    target=$(realpath "$2")

    cd "$source"

    log "Solving for $source into $target"

    solve_stow_conflicts "$target"
    if [ $? -ne 0 ]; then
        return 1
    fi

    echo
    stow --no-folding -nvt "$target" */
    echo
    if yn_pr "Do you accept these changes? [Y/n]: "; then
        if [ "$target" == "/" ]; then
            sudo stow --no-folding -vt "$target" */
        else
            stow --no-folding -vt "$target" */
        fi
        log "Stowed packages from $source"
    fi

    cd "$OLDPWD"
}

if [[ "${1:-}" == "--root" ]]; then
    stow_packages "$DOT/root" "/"
else
    stow_packages "$DOT" "$HOME"
fi
