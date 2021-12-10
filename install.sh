#!/usr/bin/env sh

function yn_pr() {
    while true; do
        read -p "$1" yn
        case $yn in
            [Yy]* | "" ) return 0;;
            [Nn]* ) return 1;;
        esac
    done
}

function is_installed() {
    if ! command -v "$1" &> /dev/null; then
        echo "The '$1' package is not installed."
        yn_pr "Do you want to install $1 with yay? [Y/n]: " && yay -S stow || exit 0
    fi
}

is_installed "stow"
is_installed "awk"

conflicts=$(stow -nt ~ */ 2>&1 | awk -v home="$HOME/" '/directory: */ {print home$NF}')

if [ -n "$conflicts" ]; then
    echo "The following conflicts were found:"
    echo "$conflicts"

    rm_pr="Do you want to REMOVE all the conflicted files? [Y/n]: "
    yn_pr "$rm_pr" && echo "$conflicts" | xargs rm || exit 0
fi

echo
stow -nvt ~ */
echo

yn_pr "Do you accept these changes? [Y/n]: " && stow -vt ~ */ || exit 0
