#!/bin/bash

# Script for creating symbolic links for my dotfiles

# Link all files in home directory to user's home directory
HOMEFILES=$(ls ~/.dotfiles/home)
for FILE in $HOMEFILES; do
    DOTFILE=~/.$FILE
    ln -sf ~/.dotfiles/home/$FILE $DOTFILE && echo $DOTFILE links to $FILE || echo $FILE not linked
done

# Move back to starting directory
cd ~/.dotfiles

mkdir  ~/.config
linkconfig() {
    # Remove old directory
    rm -r ~/.config/$1
	# If you want to move the folder instead of delete
	# mv -r ~/.config/$1 ~/.config/${1}_old

    echo linking $1
    ln -s ~/.dotfiles/$1 ~/.config && echo $1 linked || echo $1 not linked
}
linkconfig awesome
linkconfig alacritty
linkconfig nvim
