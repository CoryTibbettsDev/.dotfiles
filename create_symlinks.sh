#!/bin/bash

# Script for creating symbolic links for my dotfiles

# Make sure we are in right folder
cd ~/.dotfiles

# Link all files in home directory to user's home directory
cd home/
HOMEFILES=$(ls)
for FILE in $HOMEFILES; do
    DOTFILE=~/.$FILE
    ln -srf $FILE $DOTFILE && echo $DOTFILE links to $FILE || echo $FILE not linked
done

# Move back to starting directory
cd ~/.dotfiles

mkdir  ~/.config
linkconfig() {
    # Remove old directory
    rm -r ~/.config/$1
    echo linking $1
    ln -s ~/.dotfiles/$1 ~/.config && echo $1 linked || echo $1 not linked
}
linkconfig awesome
linkconfig alacritty
linkconfig nvim
