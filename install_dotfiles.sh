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

    local prev_dir="$PWD"
    cd "$source"

    log "Solving for $source into $target"

    if ! solve_stow_conflicts "$target"; then
        cd "$prev_dir"
        return 1
    fi

    echo
    $sudo_cmd stow --no-folding -nvt "$target" */
    echo
    if yn_pr "Do you accept these changes? [Y/n]: "; then
        $sudo_cmd stow --no-folding -vt "$target" */
        log "Stowed packages from $source"
    fi

    cd "$prev_dir"
}

function copy_packages() {
    local source="$1"
    local target=$(realpath "$2")
    local sudo_cmd=""
    if [ "$target" == "/" ]; then
        sudo_cmd="sudo"
    fi

    local prev_dir="$PWD"
    cd "$source"

    log "Preparing to copy packages from $source into $target"

    local files_to_copy=()
    while IFS= read -r -d '' file; do
        files_to_copy+=("$file")
    done < <(find . -mindepth 2 \( -type f -o -type l \) ! -name ".stow-local-ignore" ! -name ".git*" -print0 | sort -z)

    if [ ${#files_to_copy[@]} -eq 0 ]; then
        log "No files to copy in $source"
        cd "$prev_dir"
        return 0
    fi

    echo
    echo "The following files will be copied into $target:"
    local differing_files=()
    for rel_path in "${files_to_copy[@]}"; do
        local clean_rel="${rel_path#./}"
        local dest_rel="${clean_rel#*/}"
        local dest_file="${target%/}/$dest_rel"

        local status="[new]"
        if [ -L "$dest_file" ]; then
            status="[replaces symlink -> $(readlink "$dest_file")]"
        elif [ -f "$dest_file" ]; then
            if cmp -s "$rel_path" "$dest_file"; then
                status="[identical]"
            else
                status="[overwrite (differs)]"
                differing_files+=("$dest_file")
            fi
        fi
        printf "  %-24s %s -> %s\n" "$status" "$clean_rel" "$dest_file"
    done
    echo

    if [ ${#differing_files[@]} -gt 0 ]; then
        if yn_pr "Do you want to backup differing files to .old before copying? [Y/n]: "; then
            for diff_file in "${differing_files[@]}"; do
                $sudo_cmd cp -a "$diff_file" "${diff_file}.old"
                log "Backed up $diff_file to ${diff_file}.old"
            done
        fi
    fi

    if yn_pr "Do you accept these changes? [Y/n]: "; then
        for rel_path in "${files_to_copy[@]}"; do
            local clean_rel="${rel_path#./}"
            local dest_rel="${clean_rel#*/}"
            local dest_file="${target%/}/$dest_rel"
            local dest_dir="$(dirname "$dest_file")"

            $sudo_cmd mkdir -p "$dest_dir"
            $sudo_cmd cp --remove-destination "$rel_path" "$dest_file"
        done
        log "Copied packages from $source into $target"
    fi

    cd "$prev_dir"
}

target_mode="home"
copy_mode="default"

for arg in "$@"; do
    case "$arg" in
        --root)
            target_mode="root"
            ;;
        --copy)
            copy_mode="copy"
            ;;
        --stow)
            copy_mode="stow"
            ;;
        -h|--help)
            echo "Usage: $0 [--root] [--copy|--stow]"
            echo
            echo "Options:"
            echo "  --root   Deploy root configs from \$DOT/root into / (defaults to copying)"
            echo "  --copy   Copy files instead of symlinking with GNU stow"
            echo "  --stow   Symlink files with GNU stow (default for home configs)"
            exit 0
            ;;
    esac
done

if [ "$target_mode" == "root" ]; then
    if [ "$copy_mode" == "stow" ]; then
        stow_packages "$DOT/root" "/"
    else
        copy_packages "$DOT/root" "/"
    fi
else
    if [ "$copy_mode" == "copy" ]; then
        copy_packages "$DOT" "$HOME"
    else
        stow_packages "$DOT" "$HOME"
    fi
fi
