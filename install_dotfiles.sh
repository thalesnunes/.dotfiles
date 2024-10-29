#!/usr/bin/env bash

source install_utils.sh

if [ ! -d "$DOT" ]; then
    git clone https://github.com/thalesnunes/.dotfiles "$DOT"
fi

cd "$DOT"

is_installed "stow"
is_installed "awk"

conflicts=$(stow -nt ~ */ 2>&1 | awk -v home="$HOME/" '/directory: */ {print home$NF}')

if [ -n "$conflicts" ]; then
    echo "The following conflicts were found:"
    echo "$conflicts"

    rm_pr="Do you want to REMOVE all the conflicted files? [Y/n]: "
    mv_pr="Do you want to MOVE all the conflicted files to .old files? [Y/n]: "
    if yn_pr "$rm_pr"; then
        echo "$conflicts" | xargs rm -rf
    elif yn_pr "$mv_pr"; then
        echo "$conflicts" | xargs mv {} {}.old
    else
        exit 0
    fi
fi

echo
stow --no-folding -nvt ~ */
echo

yn_pr "Do you accept these changes? [Y/n]: " && stow --no-folding -vt ~ */ || exit 0
