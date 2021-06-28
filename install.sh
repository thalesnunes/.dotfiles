#!/bin/bash

sudo apt install stow

cd ~/.dotfiles

stow -nvt ~ */

read -e -p "Do you accept these changes?" choice
[[ "$choice" == [Yy]* ]] && stow -vt ~ */ || echo "Not accepted"
