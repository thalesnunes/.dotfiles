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
    local target_prefix="${target%/}"
    local sudo_cmd=""
    if [ "$target" == "/" ]; then
        sudo_cmd="sudo"
    fi

    conflicts=$( ($sudo_cmd stow --no-folding -nt "$target" */ 2>&1 || true) | awk -v prefix="$target_prefix" '
        /over existing.*target / {
            for (i=1; i<=NF; i++) {
                if ($i == "target") {
                    print prefix "/" $(i+1)
                    break
                }
            }
        }
    ')

    if [ -n "$conflicts" ]; then
        log "The following conflicts were found:"
        echo "$conflicts"

        rm_pr="Do you want to REMOVE all the conflicted files? [Y/n]: "
        mv_pr="Do you want to MOVE all the conflicted files to .old files? [Y/n]: "
        if yn_pr "$rm_pr"; then
            echo "$conflicts" | xargs -r $sudo_cmd rm -rf
            log "Removed conflicted files"
        elif yn_pr "$mv_pr"; then
            echo "$conflicts" | xargs -r -I {} $sudo_cmd mv "{}" "{}.old"
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
    local sudo_cmd=""
    if [ "$target" == "/" ]; then
        sudo_cmd="sudo"
    fi

    cd "$source"

    log "Solving for $source into $target"

    if ! solve_stow_conflicts "$target"; then
        return 1
    fi

    echo
    $sudo_cmd stow --no-folding -nvt "$target" */
    echo
    if yn_pr "Do you accept these changes? [Y/n]: "; then
        $sudo_cmd stow --no-folding -vt "$target" */
        log "Stowed packages from $source"
    fi

    cd "$OLDPWD"
}

if [[ "${1:-}" == "--root" ]]; then
    stow_packages "$DOT/root" "/"
else
    stow_packages "$DOT" "$HOME"
fi
